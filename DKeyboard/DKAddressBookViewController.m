//
//  DKAddressBookViewController.m
//  DKeyboard
//
//  Created by 王昌阳 on 2018/5/18.
//  Copyright © 2018年 王昌阳. All rights reserved.
//

#import "DKAddressBookViewController.h"
#import <APAddressBookFramework.h>

@interface DKAddressBookViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray         *contactsArr;
    UITableView     *tableView;
}

@end

@implementation DKAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    tableView.backgroundColor = [UIColor magentaColor];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    if ([APAddressBook access] != APAddressBookAccessGranted) {
        [[APAddressBook new] requestAccess:^(BOOL granted, NSError * _Nullable error) {
            if (granted && !error) {
                [self loadContacts];
            } else {
                // 展示失败的提示
            }
        }];
    } else {
        [self loadContacts];
    }
}

- (void)loadContacts {
    @weakify(self);
    [[APAddressBook new] loadContactsOnQueue:dispatch_get_global_queue(0, 0) completion:^(NSArray<APContact *> * _Nullable contacts, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            if (!error && contacts) {
                self->contactsArr = contacts;
                [self->tableView reloadData];
            } else {
                // 展示错误占位信息
            }
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate and dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return contactsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (contactsArr.count > indexPath.row) {
        APContact *contact = [contactsArr objectAtIndex:indexPath.row];
        cell.textLabel.text = [(contact.name.compositeName?:@"无") stringByAppendingString:contact.phones.firstObject.number];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [[UIViewController alloc] init];
    [self showViewController:vc sender:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
