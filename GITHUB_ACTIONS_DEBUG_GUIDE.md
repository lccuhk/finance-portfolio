# GitHub Actions 故障排查指南

## 如何查看详细的报错日志

### 方法一：GitHub 网页界面（推荐）

1. **打开 Actions 页面**
   ```
   https://github.com/lccuhk/finance-portfolio/actions
   ```

2. **点击失败的工作流**
   - 找到显示 ❌ 红色或 🟡 黄色的工作流运行记录
   - 点击工作流标题进入详情页

3. **查看具体步骤**
   - 左侧会显示所有执行步骤
   - 点击失败的步骤（显示 ❌ 的）
   - 右侧会展开详细的日志输出

4. **搜索错误关键词**
   - 在日志页面按 `Ctrl+F` (Windows) 或 `Cmd+F` (Mac)
   - 搜索关键词：`error`、`failed`、`Error`、`FAIL`

### 方法二：下载完整日志

1. 在 Actions 详情页，点击右上角的 **齿轮图标** ⚙️
2. 选择 **"Download log archive"**
3. 解压后可以用文本编辑器查看完整日志

---

## 常见错误及解决方法

### 错误 1：权限不足

**症状：**
```
Error: Resource not accessible by integration
```

**解决：**
1. 访问 `Settings > Actions > General`
2. 找到 **Workflow permissions**
3. 选择 **"Read and write permissions"**
4. 勾选 **"Allow GitHub Actions to create and approve pull requests"**
5. 点击 **Save**

---

### 错误 2：构建失败

**症状：**
```
Error: Process completed with exit code 1.
npm run build failed
```

**解决：**
1. 点击失败的 "Build" 步骤
2. 查看具体的错误信息
3. 常见原因：
   - TypeScript 类型错误 → 本地运行 `npm run check` 修复
   - 缺少依赖 → 检查 `package.json`
   - 内存不足 → 添加 `NODE_OPTIONS: '--max-old-space-size=4096'`

---

### 错误 3：部署失败

**症状：**
```
Error: Failed to create deployment
```

**解决：**
1. 检查 GitHub Pages 是否启用
2. 检查仓库是否公开
3. 检查是否有冲突的分支保护规则

---

### 错误 4：找不到构建输出

**症状：**
```
Error: No uploaded artifact was found
```

**解决：**
1. 检查 `vite.config.ts` 是否有正确的 `base` 配置
2. 确认构建命令生成 `dist` 目录
3. 检查工作流文件中的 `path: './dist'` 是否正确

---

## 如何重新运行失败的工作流

### 方法 1：网页界面

1. 进入失败的 Actions 运行页面
2. 点击右上角的 **"Re-run jobs"** 按钮
3. 选择 **"Re-run all jobs"**

### 方法 2：推送新提交

```bash
# 修改任意文件（比如更新 README）
echo "# Update" >> README.md
git add .
git commit -m "触发重新部署"
git push origin main
```

### 方法 3：空提交

```bash
git commit --allow-empty -m "重新触发部署"
git push origin main
```

---

## 本地模拟 Actions 运行

如果你想在本地测试工作流：

### 安装 act 工具
```bash
# macOS
brew install act

# 或使用 npm
npm install -g @nektos/act
```

### 运行工作流
```bash
# 运行默认工作流
act

# 运行特定工作流
act -W .github/workflows/github-pages.yml
```

---

## 调试技巧

### 1. 添加调试步骤

在工作流文件中添加调试步骤：

```yaml
- name: Debug - List files
  run: |
    echo "Current directory:"
    pwd
    echo "Files:"
    ls -la
    echo "Dist directory:"
    ls -la dist/ || echo "dist not found"
```

### 2. 启用详细日志

在仓库设置中启用调试日志：
1. 访问 `Settings > Secrets and variables > Actions`
2. 添加 `ACTIONS_STEP_DEBUG` 设置为 `true`
3. 添加 `ACTIONS_RUNNER_DEBUG` 设置为 `true`

### 3. 检查环境变量

```yaml
- name: Debug - Environment
  run: |
    echo "GitHub ref: $GITHUB_REF"
    echo "GitHub sha: $GITHUB_SHA"
    echo "GitHub actor: $GITHUB_ACTOR"
```

---

## 快速检查清单

如果部署失败，按顺序检查：

- [ ] Actions 是否启用？（Settings > Actions > General）
- [ ] 工作流文件语法是否正确？（可以用在线 YAML 验证器）
- [ ] 仓库是否公开？（Private 仓库需要 Pro 账户才能用 Pages）
- [ ] GitHub Pages 是否设置为 GitHub Actions？（Settings > Pages）
- [ ] 是否有足够的权限？（Settings > Actions > Workflow permissions）
- [ ] 构建是否成功？（检查 Build 步骤日志）
- [ ] dist 目录是否正确生成？（添加 Debug 步骤检查）

---

## 获取帮助

如果以上方法都无法解决：

1. **查看 GitHub 状态页面**
   https://www.githubstatus.com/

2. **GitHub Actions 文档**
   https://docs.github.com/en/actions

3. **GitHub Pages 文档**
   https://docs.github.com/en/pages

4. **在社区提问**
   https://github.com/orgs/community/discussions
