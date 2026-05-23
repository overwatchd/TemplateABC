#!/bin/bash
# setup.sh — 从 .template/ 创建模板文件
# 直接执行：.template/setup.sh
# macOS / Linux 使用；Windows 版本稍后补充

set -e
cd "$(git rev-parse --show-toplevel)"

echo "Setup workspace..."

ln -sf .template/CLAUDE.md CLAUDE.md
ln -sf .template/AGENTS.md AGENTS.md
cp -n .template/.gitignore .gitignore

echo "Done."
