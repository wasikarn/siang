#!/usr/bin/env bash
# skills/personal-voice/scripts/voice_stats.py measures samples, keeps a feature as a habit only when 2+ samples show it,
# lists the rest as one-offs, and flags a draft that leaves the samples' range. Run: bash tests/test-voice.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
vs="$root/skills/personal-voice/scripts/voice_stats.py"
work=$(mktemp -d)
trap 'python3 -c "import shutil,sys; shutil.rmtree(sys.argv[1])" "$work"' EXIT
fail=0
check() {  # check <label> <python expression over j (parsed JSON)>
  if python3 -c 'import json,sys; j=json.load(open(sys.argv[1])); sys.exit(0 if eval(sys.argv[2]) else 1)' "$work/out.json" "$2"; then
    echo "PASS $1"; else echo "FAIL $1: $2"; fail=1; fi
}

printf 'shipped the fix. tests green!\nmerging now - will watch ci\n' > "$work/a.txt"
printf 'pushed it. should be fine!\nping me if it breaks - i think it is ok\n' > "$work/b.txt"
printf 'one more thing; the cache (probably) needs a flush\n' > "$work/c.txt"
python3 "$vs" "$work/a.txt" "$work/b.txt" "$work/c.txt" > "$work/out.json"

check "three samples are not provisional"      'j["provisional"] is False'
check "exclamation is a habit (a and b)"       '"punctuation: exclamation" in j["habits"]'
check "spaced hyphen is a habit"               '"punctuation: spaced hyphen" in j["habits"]'
check "semicolon seen once is a one-off"       'j["one_offs"].get("punctuation: semicolon", "").endswith("c.txt")'
check "semicolon is not a habit"               '"punctuation: semicolon" not in j["habits"]'
check "lowercase starts reported"              'j["samples"][next(iter(j["samples"]))]["all_lowercase_start"] is True'
check "a.txt has 3 sentences (. and ! end one, a newline ends one)" 'j["samples"][[k for k in j["samples"] if k.endswith("a.txt")][0]]["sentences"] == 3'

python3 "$vs" "$work/a.txt" "$work/b.txt" > "$work/out.json"
check "two samples are provisional"            'j["provisional"] is True'

printf 'ปรับ config แล้วนะครับ\nรัน test ผ่านเลย\n' > "$work/th.txt"
python3 "$vs" "$work/th.txt" > "$work/out.json"
check "Thai particle counted"                  'j["samples"][next(iter(j["samples"]))]["particles"]["นะ"] == 1'
check "Thai ratio is between 0 and 1"          '0 < j["samples"][next(iter(j["samples"]))]["thai_ratio"] < 1'

printf 'I am delighted to announce that the deployment — which took several weeks — has finally completed, and we would like to thank everyone involved.\n' > "$work/draft.txt"
python3 "$vs" "$work/a.txt" "$work/b.txt" --draft "$work/draft.txt" > "$work/out.json"
check "long draft sentence flagged out of range" 'any(m["feature"] == "sentence_chars_median" for m in j["draft"]["out_of_range"])'
check "em dash outside range flagged"          'any("em dash" in m["feature"] for m in j["draft"]["out_of_range"])'
check "missing exclamation habit reported"     '"punctuation: exclamation" in j["draft"]["habits_absent"]'

python3 "$vs" "$work/a.txt" "$work/b.txt" --draft "$work/a.txt" > "$work/out.json"
check "a sample as draft has no misses"        'j["draft"]["out_of_range"] == []'

# one all-caps emphasis word in a single sample is a one-off; a draft that copies it is flagged
printf 'please do NOT merge it. ping me on OPS-2187\n' > "$work/c1.txt"
printf 'no merges to main today. ping me on OPS-2187\n' > "$work/c2.txt"
printf 'do not merge, ping me on OPS-2187\n' > "$work/c3.txt"
printf 'please do NOT deploy, ping me on OPS-2187\n' > "$work/cd.txt"
python3 "$vs" "$work/c1.txt" "$work/c2.txt" "$work/c3.txt" --draft "$work/cd.txt" > "$work/out.json"
check "caps word in one sample is a one-off"   'j["one_offs"].get("caps: NOT", "").endswith("c1.txt")'
check "caps id in every sample is a habit"     '"caps: OPS" in j["habits"]'
check "draft copying the one-off caps is flagged" 'j["draft"]["caps_not_habit"] == ["NOT"]'

# symbols: an @mention in one sample is a one-off; a draft that uses a symbol kind that is not a habit is flagged
printf -- '- 10:20 paused the consumer @nok please check\n- 10:40 done\n' > "$work/s1.txt"
printf -- '- 11:05 rolled back\n- 11:09 done\n' > "$work/s2.txt"
printf -- '- 12:30 started\n- 12:50 done\n' > "$work/s3.txt"
printf -- '- 14:22 @nok rolled back, see https://x.example/a #inc\n' > "$work/sd.txt"
python3 "$vs" "$work/s1.txt" "$work/s2.txt" "$work/s3.txt" --draft "$work/sd.txt" > "$work/out.json"
check "@mention in one sample is a one-off"    'j["one_offs"].get("symbol: mention", "").endswith("s1.txt")'
check "draft symbols that are not habits"      'j["draft"]["symbols_not_habit"] == ["hashtag", "mention", "url"]'

# number style: samples use digits, a draft that spells a number out is flagged; "one" is a pronoun and ignored
printf 'lost 38 minutes and 1,240 requests\nalert fires 14 days out\n' > "$work/n1.txt"
printf 'checkout down 40 min\nnobody noticed the one thing\n' > "$work/n2.txt"
printf 'reran 3 jobs, all green\n' > "$work/n3.txt"
printf 'alert fires two weeks out; three jobs reran; no one noticed\n' > "$work/nd.txt"
python3 "$vs" "$work/n1.txt" "$work/n2.txt" "$work/n3.txt" --draft "$work/nd.txt" > "$work/out.json"
check "sample digit counts are reported"       'j["samples"][[k for k in j["samples"] if k.endswith("n1.txt")][0]]["digit_numbers"] == 3'
check "draft number words not habits"          'j["draft"]["number_words_not_habit"] == ["three", "two"]'
python3 "$vs" "$work/n1.txt" "$work/n2.txt" "$work/n3.txt" --draft "$work/n3.txt" > "$work/out.json"
check "digits-only draft has no number words"  'j["draft"]["number_words_not_habit"] == []'

# words that only contain a particle or hedge are not one: และ (and) is not ละ, สิ่ง/สิบ are not สิ, อาจารย์ is not
# อาจ, every/delivery are not "very", adjust is not "just"; an email is not an @mention, #123 is not a hashtag,
# "ps aux" is not a P.S.; real particles at a phrase end still count, also when stacked (แล้วนะครับ)
printf 'ทีมและฝ่ายขายคุยกัน สิ่งที่ค้างมีสิบข้อ ถามอาจารย์ก่อน\n' > "$work/w1.txt"
printf 'every delivery must adjust the plan, mail bob@example.com about #123\n' > "$work/w2.txt"
printf 'ps aux shows it\n' > "$work/w3.txt"
printf 'มาเลย ไปด้วยนะ เสร็จแล้วนะครับ ส่งแล้วฮะ อาจจะช้า it just works\n' > "$work/w4.txt"
python3 "$vs" "$work/w1.txt" "$work/w2.txt" "$work/w3.txt" "$work/w4.txt" > "$work/out.json"
w() { echo "j['samples'][[k for k in j['samples'] if k.endswith('$1')][0]]"; }
check "Thai words holding a particle or hedge are not one" "$(w w1.txt)['particles'] == {} and $(w w1.txt)['hedges'] == {}"
check "every/delivery/adjust are not hedges"   "$(w w2.txt)['hedges'] == {}"
check "email and #123 are not symbols"          "$(w w2.txt)['symbols'] == {}"
check "ps aux is not a P.S."                    "'ps' not in $(w w3.txt)['symbols']"
check "real Thai particles still count"         "$(w w4.txt)['particles'] == {'เลย': 1, 'ด้วย': 1, 'นะ': 2, 'แล้ว': 2, 'ครับ': 1, 'ฮะ': 1}"
check "real hedges still count"                 "$(w w4.txt)['hedges'] == {'อาจ': 1, 'just': 1}"

# a real P.S. still counts; a polite particle glued to the next Thai word still counts, คะแนน is not คะ, #123 next to
# Thai is not a hashtag
printf 'PS I will be late\n' > "$work/p1.txt"; printf 'PS. see you\n' > "$work/p2.txt"; printf 'P.S. thanks\n' > "$work/p3.txt"
printf 'ขอบคุณครับพี่ ได้เลยค่ะทุกคน คะแนนดี fixed in #123ครับ\n' > "$work/glued.txt"
python3 "$vs" "$work/p1.txt" "$work/p2.txt" "$work/p3.txt" "$work/glued.txt" > "$work/out.json"
check "PS, PS. and P.S. are a P.S."             "all(j['samples'][[k for k in j['samples'] if k.endswith(f)][0]]['symbols'].get('ps') == 1 for f in ['p1.txt', 'p2.txt', 'p3.txt'])"
check "polite particle before Thai counts"      "$(w glued.txt)['particles'] == {'ครับ': 2, 'เลย': 1, 'ค่ะ': 1}"
check "#123 glued to Thai is not a hashtag"     "'hashtag' not in $(w glued.txt)['symbols']"

# a draft whose particles are stretched (นะะ), doubled (ครับๆ), stacked before Thai (แล้วนะคะทุกคน) or นะ before a
# name (นะพี่) has the particle, so habits_absent must not ask for it; P.Somchai is not a P.S., ปล. is; มากๆ is a hedge
printf 'ฝากด้วยนะ\nพรุ่งนี้เจอกัน\n' > "$work/h1.txt"; printf 'ส่งแล้วนะ\nเช็กอีกรอบ\n' > "$work/h2.txt"
printf 'ฝากดูนะพี่\nโอเคนะะ\nเสร็จแล้วนะคะทุกคน\nครับๆ ดีมากๆ\n' > "$work/hd.txt"
python3 "$vs" "$work/h1.txt" "$work/h2.txt" --draft "$work/hd.txt" > "$work/out.json"
check "particles the draft has are not absent"  "'particle: นะ' not in j['draft']['habits_absent']"
check "stretched, doubled, stacked particles"   "j['draft']['features']['particles'] == {'นะ': 3, 'แล้ว': 1, 'คะ': 1, 'ครับ': 1}"
check "มากๆ without a space is a hedge"         "j['draft']['features']['hedges'] == {'มาก ๆ': 1}"
printf 'P.Somchai said hi\n' > "$work/ps1.txt"; printf 'ปล. พรุ่งนี้หยุด\nปลาทูทอด\n' > "$work/ps2.txt"
python3 "$vs" "$work/ps1.txt" "$work/ps2.txt" > "$work/out.json"
check "P.Somchai is not a P.S."                 "'ps' not in $(w ps1.txt)['symbols']"
check "ปล. is a P.S., ปลา is not"               "$(w ps2.txt)['symbols'].get('ps') == 1"
printf 'fyi deploy เสร็จแล้ว\nเดี๋ยวดูให้\nok ไปต่อ\n' > "$work/mixed.txt"
python3 "$vs" "$work/mixed.txt" > "$work/out.json"
check "Thai-initial lines do not cancel lowercase style" "$(w mixed.txt)['all_lowercase_start'] is True"

printf '123 started\n456 done\n' > "$work/digits.txt"
python3 "$vs" "$work/digits.txt" > "$work/out.json"
check "no letter-initial sentence is not lowercase style" "$(w digits.txt)['all_lowercase_start'] is False"

rc=0; python3 "$vs" "$work/missing.txt" > /dev/null 2>"$work/err" || rc=$?
if [ "$rc" -eq 1 ] && grep -q "cannot read" "$work/err"; then echo "PASS missing file exits 1 with a message"
else echo "FAIL missing file: exit $rc, $(cat "$work/err")"; fail=1; fi
printf '\xff\xfe bad bytes\n' > "$work/latin1.txt"
rc=0; python3 "$vs" "$work/latin1.txt" > /dev/null 2>"$work/err" || rc=$?
if [ "$rc" -eq 1 ] && grep -q "cannot read" "$work/err"; then echo "PASS non-UTF-8 file exits 1 with a message"
else echo "FAIL non-UTF-8 file: exit $rc, $(tail -1 "$work/err")"; fail=1; fi

exit $fail
