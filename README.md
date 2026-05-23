# TemplateABC

多 Agent 工作台模板仓库。通过 [git submodule](https://git-scm.com/book/zh/v2/Git-%E5%B7%A5%E5%85%B7-%E5%AD%90%E6%A8%A1%E5%9D%97) 引入派生项目，提供统一的规则框架。

## 文件说明

| 文件 | 用途 | 派生项目 |
|------|------|----------|
| `CLAUDE.md` | Agent 入口，强制指向 AGENTS.md | 软链接 |
| `AGENTS.md` | 跨项目通用规则与机制 | 软链接 |
| `setup.sh` | 初始化脚本，创建软链接/复制文件至根目录 | 复制后执行 |
| `.gitignore` | 通用忽略策略 | 复制（首次） |

## 更新同步

模板更新后，派生项目执行：

```
git submodule update --remote
.template/setup.sh
```

## 新建派生项目

```
git submodule add https://github.com/overwatchd/TemplateABC.git .template
.template/setup.sh
```
