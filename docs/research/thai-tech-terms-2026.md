<!-- Research note, 2026-11-09. Primary sources only; every claim cites its source. Not loaded by the skill; §31 in skills/humanize/patterns-thai.md cites it. -->

# Thai and English tech terms in use, 2026

## 1. Method

**Access date for every source below is 2026-11-09 (Asia/Bangkok), unless a row says otherwise.** Source keys used in the table:

| Key | Source | Date of content |
|---|---|---|
| ORST-T | Royal Society transliteration database, https://transliteration.orst.go.th/search. Queried through the site's own public search backend for exact headword matches. | live |
| ORST-C | Royal Society coined-term database (ศัพท์บัญญัติ ๔๐ สาขาวิชา), https://coined-word.orst.go.th/. Entries come from the "คอมพิวเตอร์และเทคโนโลยีสารสนเทศ" book unless another domain is named. | live, no entry dates |
| MS-SG | Microsoft Thai Localization Style Guide, https://download.microsoft.com/download/3/f/2/3f236167-639e-46f2-8201-554c36bcbf31/tha-tha-StyleGuide.pdf | PDF created 2024-04-11, modified 2024-09-05 |
| MS-T | Microsoft Terminology Collection, THAI.tbx inside https://download.microsoft.com/download/b/2/d/b2db7a7c-8d33-47f3-b2c1-ee5e6445cf45/MicrosoftTermCollection.zip | file date 2024-11-07 |
| MS-CP | Microsoft Support Thai, "learn about Copilot prompts", https://support.microsoft.com/th-th/topic/learn-about-copilot-prompts-f6c3b467-f07c-4db1-ae54-ffac96184dd5 | undated |
| FF | Firefox Thai UI strings, https://github.com/mozilla-l10n/firefox-l10n/tree/main/th (222 .ftl files plus .properties/.dtd). Only Thai-bearing values were counted, with word boundaries. | HEAD 2026-11-09 |
| AP-2FA | Apple Support Thai, https://support.apple.com/th-th/102660 | published 2026-08-13 |
| AP-UPD | Apple Support Thai, https://support.apple.com/th-th/118575 | published 2026-09-24 |
| G-2SV | Google Account Help Thai, https://support.google.com/accounts/answer/185839?hl=th | undated (©2026) |
| G-CHR | Chrome Help Thai, https://support.google.com/chrome/answer/95414?hl=th | undated (©2026) |
| G-GEM | Gemini Help Thai, https://support.google.com/gemini/answer/13275745?hl=th | undated |
| LINE | LINE Help Center Thai category index, https://help.line.me/line/smartphone/categoryId/20007862/3/pc?lang=th | undated |
| SCB | SCB EASY product page, https://www.scb.co.th/th/personal-banking/digital-banking/scb-easy.html | undated |
| BOT | Bank of Thailand news, https://www.bot.or.th/th/news-and-media/news/news-20250819.html | 2025-08-19 |
| BOT-F / BOT-FAQ | https://www.bot.or.th/th/fraud/fraud-measure-development.html and https://www.bot.or.th/th/faqs/faqs-03.html | undated |
| PDPC / DGA / ETDA-H | Home pages https://www.pdpc.or.th/, https://www.dga.or.th/, https://www.etda.or.th/th/ | live; little text |
| ETDA-G | ETDA "Generative AI Governance Guideline for Organizations" vol. 1. The ETDA PDF link could not be found, so this is a copy at https://library.ipst.ac.th/wp-content/uploads/2024/10/GenerativeAIGovernanceGuideline_Vol1_AIGC.pdf (secondary host). ETDA AIGC page: https://www.etda.or.th/th/Our-Service/AIGC/index.aspx | PDF 2024-09-06 |
| GH | GitHub code search API, query `"<term>" language:Markdown`, `total_count` | live |
| VCT | Vibe Coding Thailand blog, https://vibecodingthailand.com/blog/ai-code-term-glossary (read from a local capture taken 2026-10-02) | 2026-10-01 |

**Caveats**
- Counts are raw occurrence counts in fetched pages or files. They were checked against the raw HTML for the Apple and Google pages.
- **GH is a proxy, not dev writing.** It is global and approximate, and it includes translated READMEs and i18n docs. Use it only for spelling ratios. Every dev-form cell that rests on GH is low confidence. `แอป` there also matches `แอปพลิเคชัน`.
- The Microsoft sources (MS-SG, MS-T) and ETDA-G are from **2024, not 2025-26**. The live 2025-26 evidence is FF, AP-*, BOT 2025-08-19, GH, VCT and the undated Google pages (©2026).
- **Could not reach:**
  - Mozilla Pontoon UI (used the l10n repo instead)
  - medium.com/linedevth (403 twice, two different fetchers)
  - kbtg.tech/th/blog (403, then 404)
  - kasikornbank.com (403)
  - LINE MAN Wongnai engineering blog (host does not resolve)
  - Individual LINE Help articles (the index only shows category names)
- **Not available:** GitHub Docs has no Thai version (https://docs.github.com/th returns 404).
- **Not found:** no Royal Society list of AI coinages (prompt, chatbot, LLM, agent in the AI sense). Searches turned up only news about Royal Society AI seminars, e.g. https://www.thaipost.net/news-update/421208/ (2023-07-27, no terms).
- **Not counted:** ORST `บัก` on GitHub, because it collides with an Isan word. GitHub use of `โคด` was also not counted.

## 2. Term table

Cell numbers are occurrence counts. "—" means no data. "no entry" means the ORST database was searched and had nothing.

| Term | UI form | Official/gov form | Dev form | Royal Society | Sources |
|---|---|---|---|---|---|
| update | อัปเดต (FF 242 vs อัพเดต 4; AP-UPD 50; G-CHR 36) | ปรับปรุง (BOT 3); MS-T has both การปรับปรุง and อัปเดต | อัปเดต (GH 68,608 vs อัพเดท 3,880 vs อัพเดต 2,308; VCT 3) | T: อัปเดต; C: ปรับ(ให้เป็นปัจจุบัน) | FF, AP-UPD, G-CHR, MS-T, GH, ORST-T/C |
| release | — | MS-T: การวางจำหน่าย, รีลีส | English (low confidence, no count) | C: ปล่อย; T: no entry | MS-T, ORST-C |
| deploy | — | MS-T: ปรับใช้; deployment → การปรับใช้งาน | English; ดีพลอย is rare (GH 391) | no entry (T, C) | MS-T, GH |
| sign in / login | Split: เข้าสู่ระบบ (FF 59, SCB, MS-T login); ลงชื่อเข้าใช้ (G-2SV 19); ลงชื่อเข้า (AP-2FA 7, FF 73) | เข้าสู่ระบบ (BOT 2) | login (assumed; no count) | C: ลงบันทึกเข้า | FF, G-2SV, AP-2FA, MS-T, BOT, ORST-C |
| sign out | ออกจากระบบ (FF 7) / ลงชื่อออก (FF 8); MS-T lists both | — | logout | C: ลงบันทึกออก | FF, MS-T, ORST-C |
| account | บัญชี (FF 95; G-2SV "บัญชี Google"; AP-2FA "บัญชี Apple"; LINE) | บัญชี (BOT 21) | account / บัญชี | T: แอ็กเคานต์; C: บัญชีผู้ใช้ | FF, G-2SV, AP-2FA, LINE, BOT, ORST |
| password | รหัสผ่าน (FF 444; Apple, Google, MS-SG) | — | password / รหัสผ่าน | T: พาสเวิร์ด; C: รหัสผ่าน | FF, MS-SG, ORST |
| cache | แคช (FF 52; MS-T) | — | cache | T: แคช; C: แคช | FF, MS-T, ORST |
| server | เซิร์ฟเวอร์ (FF 118; MS-T) | เซิร์ฟเวอร์ (ETDA-H 1) | server | T: เซิร์ฟเวอร์; C: เครื่องบริการ, ตัวบริการ | FF, MS-T, ORST |
| cloud | MS-T: ระบบคลาวด์; FF 0 | ETDA-G: "Cloud" in Latin script | cloud | no IT entry. C: เมฆ [ภูมิศาสตร์]; cloud computing → การคำนวณแบบคลาวด์, คลาวด์คอมพิวติง [ศึกษาศาสตร์] | MS-T, ETDA-G, ORST-C |
| AI | AI (FF 72 Latin, ปัญญาประดิษฐ์ 0; G-GEM 8) | AI in Latin dominates (ETDA-G 404 vs ปัญญาประดิษฐ์ 2); MS-T: "AI ; ปัญญาประดิษฐ์" | AI | C: ปัญญาประดิษฐ์ | FF, ETDA-G, MS-T, ORST-C |
| generative AI | — | "Generative AI" in Latin (ETDA-G 325) | Generative AI | no entry | ETDA-G, MS-T ("AI สร้างสรรค์") |
| prompt | Split: พรอมต์ (G-GEM 11; FF 3, devtools sense) vs พร้อมท์ (MS-CP 16; MS-T ×3) | "Prompt" in Latin (ETDA-G 9) | พรอมต์ (GH 1,402 vs พร้อมท์ 147 vs พรอมท์ 10; VCT 12 vs Latin 2) | C: ตัวพร้อม (command-line sense); T: no entry | G-GEM, MS-CP, MS-T, ETDA-G, GH, VCT, ORST-C |
| model (AI) | โมเดล (FF 24; G-GEM 7) | โมเดล (ETDA-G 43); MS-T: โมเดล / แบบจำลอง | โมเดล / model | C: ตัวแบบ; T: no entry | FF, G-GEM, ETDA-G, MS-T, ORST-C |
| LLM | — | LLM (ETDA-G 5); MS-T: โมเดลภาษาขนาดใหญ่ ; LLM | LLM | no entry | ETDA-G, MS-T |
| agent | ตัวแทน (FF 14, "DLP agent" sense; MS-T ×4) | — | เอเจนต์ (GH 2,868 vs เอเจนท์ 167); "agent" in VCT | T: เอเจนต์; C: โปรแกรมตัวแทน, โปรแกรมเอเยนต์ | FF, MS-T, GH, VCT, ORST |
| chatbot | แชทบอต (FF: "แชทบอต AI"); แชทบอท (MS-CP 1, MS-T) | "Chatbot" in Latin (ETDA-G 11 vs แชทบอท 1) | แชทบอท (GH 858) vs แชตบอต (GH 167) | no entry; T: chat → แชต | FF, MS-CP, MS-T, ETDA-G, GH, ORST-T |
| chat | แชท (FF 33, แชต 0; LINE; G-GEM 29; MS-CP) | แชท (ETDA-H) | แชท | T: แชต, แช็ต; C: แชต [นิเทศศาสตร์] | FF, LINE, G-GEM, ORST |
| API | API | MS-T: API | API | no entry | MS-T |
| app | แอป (FF 55 standalone + แอปพลิเคชัน 86; G-GEM 74; SCB) | แอปพลิเคชัน (BOT 8) > แอป (BOT 3) | แอป (GH 53,376, includes แอปพลิเคชัน) vs แอพ (3,632) | T: แอป, แอ็ป; application → แอปพลิเคชัน; C: application → การประยุกต์ | FF, G-GEM, SCB, BOT, GH, ORST |
| notification | การแจ้งเตือน (FF 61; MS-T ×5; LINE category) | การแจ้งเตือน (BOT 4) | notification | no IT entry | FF, MS-T, LINE, BOT |
| settings | การตั้งค่า (FF 346; Apple, Google, MS-T) | การตั้งค่า (PDPC, DGA cookie settings) | settings / config | no IT entry | FF, AP-UPD, MS-T, PDPC |
| upload / download | อัปโหลด (FF 42) / ดาวน์โหลด (FF 190; MS-SG) | ดาวน์โหลด (BOT 2) | same, or English | T and C: อัปโหลด, ดาวน์โหลด | FF, MS-SG, BOT, ORST |
| sync | ซิงค์ (FF 135; MS-T ×3) | — | sync | C [เทคโนโลยีทางภาพ]: ทำให้พร้อมสัมพันธ์, สมวาร, **ซิงก์** | FF, MS-T, ORST-C |
| backup | สำรองข้อมูล (FF 56; AP-UPD); backup codes → รหัสสำรอง (G-2SV) | — | backup | C: สำรอง | FF, AP-UPD, G-2SV, ORST-C |
| bug | ข้อผิดพลาด for errors (FF 188); บั๊ก (FF 13, plus ดีบั๊ก 66); MS-T: บัก ×2 | — | บั๊ก (GH 8,848) | **T: บัก**; C: จุดบกพร่อง; debug → แก้จุดบกพร่อง | FF, MS-T, GH, ORST |
| feature | คุณลักษณะ (FF 103, ฟีเจอร์ 3; MS-T ×3) vs ฟีเจอร์ (G-GEM 20) | — | ฟีเจอร์ / feature | **T: ฟีเชอร์** | FF, MS-T, G-GEM, ORST-T |
| dashboard | แดชบอร์ด (FF "แดชบอร์ดการป้องกัน"; MS-T ×8) | — | dashboard | no IT entry | FF, MS-T |
| browser | เบราว์เซอร์ (FF 191; G-CHR) | — | browser | C: โปรแกรมค้นดู, เบราว์เซอร์ | FF, G-CHR, ORST-C |
| link | ลิงก์ (FF 138, ลิงค์ 0; SCB 24; AP 2; MS-T ×4) | ลิงก์ (BOT 2) | ลิงก์ (GH 25,408 vs ลิงค์ 2,868) | T: ลิงก์; C: เชื่อมโยง, โยง | FF, SCB, BOT, GH, ORST |
| QR code | "รหัส QR" (FF 12 vs คิวอาร์ 6); "QR Code" (SCB 4); MS-T: คิวอาร์โค้ด | — | QR | no entry | FF, SCB, MS-T |
| OTP | no primary source fetched | not on the 3 BOT pages checked | OTP | no entry | — |
| e-wallet | no primary source found | none | — | no entry | — |
| 2FA / 2-step | Three forms: การยืนยันแบบ 2 ขั้นตอน (Google, 28); การตรวจสอบสิทธิ์สองปัจจัย (Apple, 24); MS-T: การรับรองความถูกต้องด้วยสองปัจจัย / การตรวจสอบสองชั้น | BOT search summary says ยืนยันตัวตนหลายปัจจัย (not verified on a page) | 2FA / MFA | authentication → การพิสูจน์ตัวจริง | G-2SV, AP-2FA, MS-T, ORST-C |
| privacy | ความเป็นส่วนตัว (FF 108; MS-T) | ความเป็นส่วนตัว (PDPC 4, DGA 5) | privacy | C: ภาวะส่วนตัว | FF, PDPC, DGA, ORST-C |
| cookie | คุกกี้ (FF 191) | คุกกี้, plus "Cookies" in Latin on the banner (PDPC 7) | cookie | T and C: คุกกี้ | FF, PDPC, ORST |
| data / database | ข้อมูล / ฐานข้อมูล (FF 27) | ฐานข้อมูล (BOT-FAQ 4) | data, DB, ฐานข้อมูล | C: ข้อมูล, ฐานข้อมูล; T: data → ดาตา | FF, BOT-FAQ, ORST |
| version | รุ่น (FF 124*, เวอร์ชัน 2); เวอร์ชัน (G-CHR 8); **เวอร์ชั่น (AP-UPD 7)** | DGA: รุ่น 2 / เวอร์ชัน 2 | เวอร์ชัน (GH 38,560 vs เวอร์ชั่น 1,748) | T: เวอร์ชัน; C: รุ่น | FF, G-CHR, AP-UPD, GH, ORST |
| repository | — | MS-T: ที่เก็บ | repo (no count) | no entry | MS-T |
| branch | — | MS-T: สาขา (mostly the business sense) | branch | C: กิ่ง; T: บรานช์, แบรนช์ | MS-T, ORST |
| merge | — | MS-T: ผสานแทนที่ / รวมเข้าด้วยกัน | merge (เมิร์จ GH 20, rare) | C: ผสาน; T: เมิร์จ | MS-T, GH, ORST |
| commit | — | — | commit; คอมมิต (GH 1,158) vs คอมมิท (50) | no entry | GH |
| pull request | — | MS-T: คำขอดึงข้อมูล | PR | no entry | MS-T |
| container | — | MS-T: คอนเทนเนอร์ ×4 | container | T: คอนเทนเนอร์ | MS-T, ORST-T |
| token | โทเค็น (FF 31; MS-T ×7) | โทเคน (BOT-F 1, non-standard) | token | C: โทเค็น | FF, MS-T, BOT-F, ORST-C |
| streaming | สตรีม (FF 9), สตรีมมิ่ง (FF 1) | MS-T: การส่งกระแสข้อมูล | streaming | T: สตรีมมิง; C: การส่งต่อเนื่อง [เทคโนโลยีทางภาพ] | FF, MS-T, ORST |
| session | เซสชัน (FF 47; MS-T ×4) | — | session; เซสชัน (GH 5,008 vs เซสชั่น 216) | **T: no entry; C: ช่วงเวลา** | FF, MS-T, GH, ORST |
| file | ไฟล์ (FF 712, แฟ้ม 0). MS-SG: Windows strings use แฟ้ม, Office strings use ไฟล์ | ไฟล์ | file | C: แฟ้ม, แฟ้มข้อมูล | FF, MS-SG, ORST-C |
| email | อีเมล (FF 87; MS-T) | อีเมล (BOT 2, DGA 4) | อีเมล (GH 19,040 vs อีเมล์ 926) | T: no entry; coined จดหมายอิเล็กทรอนิกส์ (per secondary source BKB*) | FF, BOT, GH |
| digital | ดิจิทัล (FF 54 vs ดิจิตอล 3) | ดิจิทัล (BOT 13, DGA 37) | ดิจิทัล (GH 8,800 vs ดิจิตอล 587) | T: ดิจิทัล | FF, BOT, DGA, GH, ORST-T |
| code | โค้ด (VCT 33) | C: รหัส, รหัสคำสั่ง | โค้ด (GH 74,624) | **T: โคด**; C: source code → รหัสต้นฉบับ | VCT, GH, ORST |
| check (verb) | — (no verb use in FF, AP-*, G-*, SCB, LINE, MS-SG; MS-T has 20 เช็ค hits, all check-in/out, checkmate or cheque) | เช็ก (BOT, BOT-F, BOT-FAQ: 14 raw hits, about 3 distinct phrases) | เช็ค (GH 38,912 vs เช็ก 26,080; verb probes `...ว่า` 4,240 vs 1,720, `...ดู` 133 vs 44) | **T: เช็ก** (also เช็กอิน, เช็กเอาต์, เช็กลิสต์); เช็ค is the T form for "cheque" | BOT, BOT-F, BOT-FAQ, MS-T, GH, ORST-T |
| project | — (none in FF, AP-*, G-2SV, G-CHR, SCB, BOT, LINE; G-GEM โปรเจ็กต์ 2) | — (MS-T: one compound, แมโครโปรเจ็กต์) | โปรเจกต์ (GH 33,856) vs โปรเจค 9,408 vs โปรเจ็กต์ 7,248 vs โปรเจ็ค 956 | T: พรอเจกต์ (noun), โพรเจกต์ (verb); no entry for any โปรเจ- form | G-GEM, MS-T, GH, ORST-T |

\*FF's รุ่น count also includes other senses of the word. BKB = https://www.bangkokbiznews.com/news/detail/888035 (secondary, undated, likely 2020).

## 3. Notable changes and disagreements

1. **The Royal Society spelling and real usage split on several common words.** ORST-T gives `ฟีเชอร์`, `โคด`, `บัก`, `แชต`, and ORST-C gives `ซิงก์`. Products and dev text use `ฟีเจอร์`, `โค้ด`, `บั๊ก`, `แชท`, `ซิงค์` instead: FF, LINE, G-GEM, MS-T, GH. No product source uses the ORST form for these, except MS-T's `บัก` ×2.
2. **Most other spellings follow ORST.** อัปเดต, ลิงก์, แอป, อีเมล, ดิจิทัล and เวอร์ชัน win in FF and on Google, and strongly on GitHub (roughly 10:1 to 30:1). Apple is one exception: its 2026-09-24 page writes `เวอร์ชั่น` 7 times.
3. **Sign in has three product forms:** เข้าสู่ระบบ (Microsoft, banks, BOT), ลงชื่อเข้าใช้ (Google), and ลงชื่อเข้า (Apple; Firefox mixes in เข้าสู่ระบบ). The ORST coinage ลงบันทึกเข้า does not appear in any product source checked.
4. **Prompt splits by vendor.** Google uses `พรอมต์`. Microsoft uses `พร้อมท์` on its Copilot help page and in its 2024 terminology. GitHub Markdown and a 2026 Thai dev blog (VCT) use พรอมต์. ORST has no entry for the AI sense.
5. **2FA has three different Thai phrasings** (Google, Apple, Microsoft). None is an ORST term.
6. **Government AI text keeps English.** ETDA's 2024 guideline writes AI, Generative AI, Prompt, Chatbot and LLM in Latin script and uses ปัญญาประดิษฐ์ only twice. No 2025-26 Royal Society AI coinage list was found.
7. **Feature splits by vendor:** คุณลักษณะ (Microsoft, Firefox) vs ฟีเจอร์ (Google Gemini).
8. **Microsoft file vs แฟ้ม:** Microsoft's own style guide uses แฟ้ม in Windows strings and ไฟล์ in Office strings (MS-SG §2.2.2). Firefox uses only ไฟล์.
9. **Check and project have no product majority** (counted 2026-11-09). `เช็ก` splits the other way from item 1: GitHub leans `เช็ค` (about 1.5x overall, 2.5x in the `...ว่า` probe), but ORST-T gives `เช็ก` for the verb and BOT, the only product-side source that uses it, writes `เช็ก`; no product writes `เช็ค` for the verb. For project, no product uses any form often; on GitHub `โปรเจกต์` is about 3.6x `โปรเจค` and 4.7x `โปรเจ็กต์`, and ORST's own `พรอเจกต์` has effectively no usage. GH เช็ก also counts the Czech sense and เช็กลิสต์. siang uses `เช็ก` and `โปรเจกต์` (§31).

## 4. Implications for siang §31 (proposed)

1. **Add an "ORST vs usage" exception note.** Today §31 says "verify at ORST, never transliterate ad hoc", which would push writers to forms no product uses (ฟีเชอร์, โคด, แชต, ซิงก์). Proposal: for these five terms use the established forms ฟีเจอร์, โค้ด, บั๊ก, แชท, ซิงค์, and say plainly that this is a deliberate departure from ORST. (Evidence: ORST-T and ORST-C vs FF, LINE, G-GEM, MS-T, GH.)
2. **bug row:** keep `บั๊ก (dev chat)`, but note that the ORST spelling is `บัก` (ORST-T) and that MS-T uses บัก. User-facing `ข้อผิดพลาด` is supported (FF 188).
3. **session row:** the claim "ทับศัพท์ตามราชบัณฑิตฯ" is wrong. ORST-T has no entry, and ORST-C's coined word is `ช่วงเวลา`. Reword it to: "เซสชัน (matches the ORST -sion pattern as in เวอร์ชัน; the form MS-T and Firefox use)". The before/after example (เซสชั่น → เซสชัน) still holds (GH 5,008 vs 216).
4. **login/logout row:** user-facing should be "match the product's own string". เข้าสู่ระบบ is the default (MS-T, BOT, SCB), but Google uses ลงชื่อเข้าใช้ and Apple uses ลงชื่อเข้า. Mixing forms inside one product breaks "one form per term".
5. **deploy row:** user-facing `นำขึ้นใช้งาน` has no primary source. Microsoft uses `ปรับใช้` / `การปรับใช้งาน` (MS-T). Either cite MS or mark นำขึ้นใช้งาน as siang's own choice.
6. **merge row:** user-facing `รวมโค้ด` is fine as plain Thai. For reference, ORST-C gives ผสาน and MS-T gives รวมเข้าด้วยกัน. Note that โค้ด itself is the non-ORST form (see item 1).
7. **Add rows with sources:**
   - update → อัปเดต (not อัพเดท)
   - app → แอป (not แอพ)
   - link → ลิงก์
   - email → อีเมล
   - digital → ดิจิทัล
   - version → เวอร์ชัน (Apple's เวอร์ชั่น is non-ORST; รุ่น is the Firefox/ORST-C translation)
   - prompt → พรอมต์ (Microsoft uses พร้อมท์; follow the product when quoting its UI)
   - AI → keep Latin, even in government text (ETDA-G)
   - chatbot → แชทบอต/แชทบอท vary; prefer English "chatbot" in dev text
   - 2FA → use the platform's own phrase when giving instructions
   - notification → การแจ้งเตือน
   - settings → การตั้งค่า
8. **Audience line nuance:** "government readers get less English" holds for everyday terms (BOT uses แอปพลิเคชัน and การแจ้งเตือน). It does not hold for AI vocabulary, where ETDA writes Latin AI, Generative AI, Prompt and Chatbot.
9. **The current line-58 spellings all check out:** แคช, เบราว์เซอร์, อัปโหลด, ฟังก์ชัน, โพรโทคอล, ไฟร์วอลล์ match ORST-T or ORST-C, and so do the coinages จุดบกพร่อง, ลงบันทึกเข้า, กิ่ง.

## 5. Open questions and low-confidence rows

- **Dev form for deploy, release, commit, merge, branch, repository, PR, container and API** rests on GH spelling ratios and assumption. No first-party Thai engineering blog could be fetched (LINE Dev TH, KBTG and LMWN were blocked or unreachable). VCT is a Thai dev-education blog, not a company engineering blog.
- **OTP and e-wallet:** no primary UI or government text was fetched. The bank FAQ (403) and the BOT mobile-banking notices are worth one more try.
- **Agent in the AI sense:** no 2025-26 product UI source. The FF and MS-T `ตัวแทน` hits are the older "software agent" sense.
- **Microsoft terminology and style guide are 2024.** Current Microsoft UI may differ, for example พร้อมท์ in Copilot.
- **Google pages carry no article date** (only ©2026).
- **FF counts are approximate:** รุ่น includes non-version senses, and `AI` may include a few acronyms.
- **ETDA-G was read from a secondary host**, and pdftotext's Thai extraction may drop marks.
- **No Royal Society AI coinages found** for prompt, chatbot, LLM or generative AI. That is absence of evidence, not proof that none exist.

---
Not done: I didn't try Firecrawl on the blocked blogs or Pontoon's UI, and I didn't count `โคด`/`บัก` on GitHub. Risk: the GitHub ratios include translated docs, so treat them as spelling signals only.
