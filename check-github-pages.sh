#!/bin/bash

echo "=========================================="
echo "  GitHub Pages 部署诊断"
echo "=========================================="
echo ""

# 检查仓库设置
echo "1. 检查远程仓库..."
git remote -v
echo ""

# 检查分支
echo "2. 检查当前分支..."
git branch -a
echo ""

# 检查 GitHub Pages 配置文件
echo "3. 检查工作流文件..."
if [ -f ".github/workflows/github-pages.yml" ]; then
    echo "✓ github-pages.yml 存在"
    cat .github/workflows/github-pages.yml | head -20
else
    echo "✗ github-pages.yml 不存在"
fi
echo ""

# 检查 vite 配置
echo "4. 检查 vite.config.ts base 配置..."
grep -n "base:" vite.config.ts || echo "✗ base 未配置"
echo ""

# 检查 dist 目录
echo "5. 检查 dist 目录..."
if [ -d "dist" ]; then
    echo "✓ dist 目录存在"
    ls -la dist/
else
    echo "✗ dist 目录不存在（需要运行 npm run build）"
fi
echo ""

# 检查 index.html
echo "6. 检查 dist/index.html..."
if [ -f "dist/index.html" ]; then
    echo "✓ index.html 存在"
    head -10 dist/index.html
else
    echo "✗ index.html 不存在"
fi
echo ""

echo "=========================================="
echo "  诊断完成"
echo "=========================================="
echo ""
echo "GitHub Pages 设置检查清单："
echo "  1. 访问 https://github.com/lccuhk/finance-portfolio/settings/pages"
echo "  2. 确认 Source 设置为 'GitHub Actions'"
echo "  3. 确认仓库是公开的（Settings > General > Visibility）"
echo ""
echo "如果设置正确，请等待 5-10 分钟后访问："
echo "  https://lccuhk.github.io/finance-portfolio/"
echo ""
