# TemplateABC

多 Agent 工作台模板仓库。通过 [git submodule](https://git-scm.com/book/zh/v2/Git-%E5%B7%A5%E5%85%B7-%E5%AD%90%E6%A8%A1%E5%9D%97) 引入派生项目，提供统一的规则框架和启动脚本。

## 文件说明

| 文件 | 用途 |
|------|------|
| `CLAUDE.md` | Agent 入口，强制指向 AGENTS.md |
| `AGENTS.md` | 跨项目通用规则与机制 |
| `.gitignore` | 通用忽略策略 |

## 派生项目使用方式

```
git submodule add https://github.com/overwatchd/TemplateABC.git .template
./setup.sh    # 创建模板文件软链接至项目根目录
```

模板文件由 `.template/` 统一管理，派生项目通过 `git submodule update --remote` 同步更新。
