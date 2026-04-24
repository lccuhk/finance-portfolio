#!/bin/bash

# Git 仓库设置脚本
# 用于初始化本地仓库、配置远程地址并推送代码

set -e  # 遇到错误立即退出

echo "=========================================="
echo "  Git 仓库设置脚本"
echo "=========================================="
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 远程仓库地址
REMOTE_URL="https://github.com/lccuhk/finance-portfolio.git"

echo -e "${YELLOW}步骤 1: 检查 Git 是否已初始化...${NC}"
if [ -d ".git" ]; then
    echo -e "${GREEN}✓ Git 已初始化${NC}"
    echo ""
    
    echo -e "${YELLOW}步骤 2: 检查当前远程地址...${NC}"
    git remote -v
    echo ""
    
    echo -e "${YELLOW}步骤 3: 更新远程仓库地址...${NC}"
    git remote set-url origin "$REMOTE_URL"
    echo -e "${GREEN}✓ 远程地址已更新为: $REMOTE_URL${NC}"
else
    echo -e "${YELLOW}Git 未初始化，正在初始化...${NC}"
    git init
    echo -e "${GREEN}✓ Git 初始化完成${NC}"
    echo ""
    
    echo -e "${YELLOW}步骤 2: 添加远程仓库...${NC}"
    git remote add origin "$REMOTE_URL"
    echo -e "${GREEN}✓ 远程仓库已添加: $REMOTE_URL${NC}"
fi

echo ""
echo -e "${YELLOW}步骤 4: 验证远程地址...${NC}"
git remote -v
echo ""

echo -e "${YELLOW}步骤 5: 检查文件状态...${NC}"
git status
echo ""

echo -e "${YELLOW}步骤 6: 添加所有文件到暂存区...${NC}"
git add .
echo -e "${GREEN}✓ 文件已添加${NC}"
echo ""

echo -e "${YELLOW}步骤 7: 创建提交...${NC}"
COMMIT_MSG="feat: 初始化金融资产配置网站

- 创建 React + TypeScript + Vite 项目
- 实现首页、产品中心、资产配置、收益计算器、投资指南页面
- 集成 Recharts 图表库展示资产配置饼图和柱状图
- 添加 Tailwind CSS 样式
- 配置 Vercel 部署"

git commit -m "$COMMIT_MSG"
echo -e "${GREEN}✓ 提交已创建${NC}"
echo ""

echo -e "${YELLOW}步骤 8: 推送到远程仓库...${NC}"
echo "正在推送到 main 分支..."
git push -u origin main
echo -e "${GREEN}✓ 推送完成${NC}"
echo ""

echo "=========================================="
echo -e "${GREEN}  所有操作已完成！${NC}"
echo "=========================================="
echo ""
echo "远程仓库地址: $REMOTE_URL"
echo ""
echo "你可以访问以下链接查看代码:"
echo "  https://github.com/lccuhk/finance-portfolio"
echo ""
