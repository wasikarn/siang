#!/usr/bin/env bash
# Plants thumb.py (3.0.0), CHANGELOG.md and a stale OPTIONS.md that still describes 2.x.
# Facts only the fixture holds: --output was renamed --out-dir; --keep-exif was removed (metadata is
# always stripped); jpeg output was dropped and --format now defaults to webp (choices png, webp, avif);
# the --quality default dropped from 85 to 82, which only thumb.py shows (the CHANGELOG is silent).
# Unchanged on purpose: --width default 320.
cat > thumb.py <<'EOF'
#!/usr/bin/env python3
"""thumb.py: write a thumbnail for each image given on the command line."""
import argparse
import sys

__version__ = "3.0.0"


def parse_args(argv):
    p = argparse.ArgumentParser(prog="thumb.py")
    p.add_argument("images", nargs="+", metavar="IMAGE")
    p.add_argument("--width", type=int, default=320, help="thumbnail width in pixels; height keeps the aspect ratio")
    p.add_argument("--format", choices=["png", "webp", "avif"], default="webp", help="output format")
    p.add_argument("--quality", type=int, default=82, help="encoder quality, 1-100 (ignored for png)")
    p.add_argument("--out-dir", default="thumbs", help="directory the thumbnails are written to")
    p.add_argument("--version", action="version", version=__version__)
    args = p.parse_args(argv)
    if not 1 <= args.quality <= 100:
        p.error("--quality must be between 1 and 100")
    return args


def main(argv=None):
    args = parse_args(sys.argv[1:] if argv is None else argv)
    for image in args.images:
        # EXIF and all other metadata are always stripped.
        print(f"{image} -> {args.out_dir}/ ({args.format}, {args.width}px, q{args.quality})")


if __name__ == "__main__":
    main()
EOF

cat > CHANGELOG.md <<'EOF'
# Changelog

## 3.0.0 - 2026-11-03

### Breaking

- `--output` is now `--out-dir`. The old name is rejected.
- `--keep-exif` is gone: thumbnails never carry EXIF or other metadata.
- JPEG output was dropped. `--format` takes `png`, `webp` or `avif`, and defaults to `webp`.

### Added

- `--version`.

## 2.3.1 - 2026-07-19

- Fixed rounding of odd widths.
EOF

cat > OPTIONS.md <<'EOF'
# thumb.py options

Usage: `python3 thumb.py [options] IMAGE...`

| Option | What it does | Default |
|---|---|---|
| `--width N` | Thumbnail width in pixels; height keeps the aspect ratio | `320` |
| `--format FMT` | Output format: `jpeg` or `png` | `jpeg` |
| `--quality Q` | Encoder quality, 1-100 | `85` |
| `--output DIR` | Directory the thumbnails are written to | `./thumbs` |
| `--keep-exif` | Copy EXIF metadata into the thumbnail | off |
EOF
