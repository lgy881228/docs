## xengine.ui.showLoading

- 显示 loading 提示框
- 需主动调用 `xengine.ui.hideLoading`才能关闭提示框。

**示例**	

```javascript
// 显示提示框
xengine.ui.showLoading();
// 隐藏提示框
xengine.ui.hideLoading();
```



---



### xengine.ui.showModal(Object)

- 显示模态弹窗，类似于标准 html 的消息框：alert、confirm。

**Object参数说明**	

|    参数    |   类型   | 必填 | 默认值 |          说明          |
| :--------: | :------: | :--: | :----: | :--------------------: |
|   title    |  string  |  否  |  ---   |       提示的标题       |
|  content   |  string  |  否  |  ---   |       提示的内容       |
| showCancel | Boolean  |  否  |  true  |    是否显示取消按钮    |
|  success   | Function |  否  |  ---   | 接口调用成功的回调函数 |
|    fail    | Function |  否  |  ---   | 接口调用失败的回调函数 |

**示例**	

```javascript
xengine.ui.showModal({ 
  title: "title", 
  content: "content", 
  showCancel: 'true' 
});
```



---



### xengine.ui.showActionSheet(Object)

- 显示操作菜单

**Object参数说明**	

|   参数   |     类型      | 必填 | 默认值 |           说明           |
| :------: | :-----------: | :--: | :----: | :----------------------: |
| itemList | Array<string> |  是  |  ---   | 按钮的文字数组,最大长度6 |
|  title   |    string     |  否  |  ---   |        提示的标题        |
| content  |    string     |  否  |  ---   |        提示的内容        |
| success  |   Function    |  否  |  ---   |  接口调用成功的回调函数  |
|   fail   |   Function    |  否  |  ---   |  接口调用失败的回调函数  |

**示例**	

```javascript
xengine.ui.showActionSheet({ 
  title: 'title',
  content: 'content',
  itemList : ['测试1','测试2','测试3','测试4','测试5']
}); 
```



---



### xengine.ui.showToast(Object)

- 显示消息提示框。

**Object参数说明**		

|   参数   |  类型  | 必填 | 默认值 | 说明 |
| :------: | :----: | :--: | :----: | :--: |
|  title   | string | ---- |  ----  | ---- |
| duration | number | ---- |  2000  | ---- |

**示例**	

```javascript
xengine.ui.showToast({
  title: 'toast' 
});
xengine.ui.showSuccessToast({
  title:"成功"
});
xengine.ui.showFailToast({
  title:"失败"
});
```

