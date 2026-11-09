#!/usr/bin/env bash
python3 - <<'PY'
lines = [
    'คณะวิทยาศาสตร\uf70eเทคโนโลยีและการเกษตร',
    'ตำราเล\uf70aมนี้ ได\uf70bกล\uf70aาวถึงปั\uf710จจั\uf710ย',
    'หมายเหตุ\uf71bรายการที่สอง',
]
open('raw.txt', 'w', encoding='utf-8').write(chr(10).join(lines) + chr(10))
PY
