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

if python3 "$vs" "$work/missing.txt" > /dev/null 2>"$work/err"; then
  echo "FAIL missing file should exit non-zero"; fail=1
elif grep -q "cannot read" "$work/err"; then echo "PASS missing file exits non-zero with a message"
else echo "FAIL missing file message"; fail=1; fi

exit $fail
