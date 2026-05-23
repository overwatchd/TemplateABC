#!/bin/bash
# setup.sh — 从 .template/ 创建模板文件软链接
# macOS / Linux 使用；Windows 版本稍后补充

set -e
cd "$(dirname "$0")"

echo "Setup ABC workspace..."

ln -sf .template/CLAUDE.md CLAUDE.md
ln -sf .template/AGENTS.md AGENTS.md
cp -n .template/.gitignore .gitignore

echo "Done. Template files linked from .template/"
