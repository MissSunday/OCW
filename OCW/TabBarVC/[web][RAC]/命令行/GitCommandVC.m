//
//  GitCommandVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/8/22.
//

#import "GitCommandVC.h"

@interface GitCommandVC ()
@end

@implementation GitCommandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateDataArray:@[
        @{@"title":@"git常用命令",
          @"content":@[
              @{@"command":@"git init",
                @"des"    :@"在当前目录新建一个仓库"},
              @{@"command":@"git init [project-name]",
                @"des"    :@"在一个目录下新建本地仓库"},
              @{@"command":@"git clone [url]",
                @"des"    :@"克隆一个远程仓库"},
              @{@"command":@"git status [file-name]",
                @"des"    :@" 查看指定文件状态"},
              @{@"command":@"git status",
                @"des"    :@"查看所有文件状态"},
              @{@"command":@"git add [file-name1] [file-name2] ...",
                @"des"    :@"从工作区添加指定文件到暂存区"},
              @{@"command":@"git add .",
                @"des"    :@"将被修改的文件和新增的文件提交到暂存区，不包括被删除的文件"},
              @{@"command":@"git add -u .",
                @"des"    :@"u指update，将工作区的被修改的文件和被删除的文件提交到暂存区，不包括新增的文件"},
              @{@"command":@"git add -A .",
                @"des"    :@"A指all，将工作区被修改、被删除、新增的文件都提交到暂存区"},
              @{@"command":@"git commit -m [massage]",
                @"des"    :@"将暂存区所有文件添加到本地仓库"},
              @{@"command":@"git commit [file-name-1] [file-name-2] -m [massage]",
                @"des"    :@"将暂存区指定文件添加到本地仓库"},
              @{@"command":@"git commit -am [massage]",
                @"des"    :@"将工作区的内容直接加入本地仓库"},
              @{@"command":@"git commit --amend",
                @"des"    :@"快速将当前文件修改合并到最新的commit，不会产生新的commit"},
              @{@"command":@"git clean -df",
                @"des"    :@"加-d是指包含目录，加-f是指强制，删除所有未跟踪的文件"},
              @{@"command":@"git log",
                @"des"    :@"显示所有commit日志"},
              @{@"command":@"git log --pretty=oneline",
                @"des"    :@"将日志缩写为单行显示"},
              @{@"command":@"git log --graph --pretty=oneline --abbrev-commit",
                @"des"    :@"查看分支合并情况"},
              @{@"command":@"git log --oneline --decorate --graph --all",
                @"des"    :@"查看分叉历史，包括：提交历史、各个分支的指向以及项目的分支分叉情况"},
              @{@"command":@"git log -3",
                @"des"    :@"查看最新3条commit日志数据"},
          ]
        }
    ]
    ];
    
}

@end

