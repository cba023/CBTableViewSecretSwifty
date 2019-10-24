# CBTableViewSecret
### 前言
tableView可以说是iOS开发中使用频率最高的容器视图了。正是因为它的使用频率高，所以时常引人思索。大家都知道，tableView数据的呈现和控制是依靠UITableViewDataSource和UITableViewDelegate来实现的。反反复复，冷冷清清，对于我们来说，也许按照苹果官方提供的编码方式非常简单易懂，但是，当显示的视图类型繁多，数据复杂的时候，可能在代理函数中就需要去处理大量的计算，还有逻辑判断。这给我们的开发带来了难度。
纵观世面上对待tableView普遍抱着不太热情却还能容忍的态度，所以大多数人还是把苹果提供给我们的代理函数作为编写tableView页面的默认选择。
问题来了，有没有更好的开发方式呢，当然有，本人在长期与tableView“打交道”的基础上，总结出了一套开发方式。这就是基于官方代理封装的TableViewSecret。先让我们来看一段代码，如下：

```
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row % 2 == 0) {
            return UITableViewAutomaticDimension;
        } else {
            return 70.0;
        }
    } else if (indexPath.section == 1) {
        return 100.0;
    } else {
        if (indexPath.row == 0) {
            return self.tableView.bounds.size.width / 16.0 * 9.0;
        } else {
            return 80.0;
        }
    }
}
```
该代码是tableView的代理函数设定cell高度的方法。当cell类型繁多的时候，是不是可阅读性变得非常糟糕。维护起来也非常吃力。这里的表格操作都是代理函数集中处理的。而现在，我们可以对这种写法说再见。
让它以组或行为单位，即一个section中包含若干的row，每个section或row都可以设置对应的参数，然后再通过数据模型组装的方式把要呈现的数据拼接起来。


### 优势和特点

* 更少代码量
*  不用再计算需要多少分组多少行，代码中累加
* cell类型过多的时候tableView分组和分行免去大量判断，更好控制
* 处理事件更加清晰，把事件的持有对象由tableView转移到display，即行列数据本身持有者

### 实现

#### CBTableViewSecret
项目中引入类 CBTableViewDisplay，旨在代替tableView所属的controller成为tableView的dataSource和delegate。然后一系列的代理函数都由secret来实现。
此时secret是通用类，不提倡开发者直接更改，除非添加tableView的代理功能的实现借口，所以此处借助CBTableViewDisplay类，在tableView所在的controller中创建一个secret，secret与tableView相互关联。
> 创建CBTableViewSecret实例并关联tableView,关联display

```
+ (instancetype)secretWithTableView:(UITableView *)tableView display:(CBTableViewDisplay *)display;
```

这样一来，实际上tableView真正的数据源和代理变成了display,我们可以用display来对tableView的呈现实现控制。

#### 各层display
display自内向外包含三个层级，分别用3个类来定义，如下：

类名 | 用途
--------- | -------------
CBTableViewRowDisplay | tableView行呈现类。用于确定cell的呈现数据和代理方法
CBTableViewSectionDisplay | tableView分组呈现类。用于确定每组header和footer的呈现数据和代理方法；同时也是CBTableViewRowDisplay信息的容器类
CBTableViewDisplay | 外层类。用作CBTableViewSectionDisplay的外部调用容器类

通过上面层层嵌套实现了tableView的数据源和代理已经为display类控制，此处display类也是设计的通用类，实际使用中尽量不让开发者更改源码，所以这里用block回调的方式，实现了调用呈现方法的时候实现正反向双向传值，让开发者在controller中调用这些决定tableView呈现的数据。方法声明如下：

> CBTableViewDisplay

```
init(sectionsCallback: (_ sections: inout Array<TableViewSectionDisplay>) -> Void)
```

> CBTableViewSectionDisplay

```
init(headerHeight: CGFloat, footerHeight: CGFloat, autoHeaderHeight: Bool, autoFooterHeight: Bool, viewForHeader:((_ tableView: UITableView?, _ section: Int) -> UIView)?, viewForFooter:((_ tableView: UITableView?, _ section: Int) -> UIView)?, rowsCallback: (_ rows: inout Array<TableViewRowDisplay>) -> Void)
```

> CBTableViewRowDisplay

```
init(cellHeight:CGFloat, autoCellHeight:Bool, cellForRowAt indexPath:@escaping (_ tableView: UITableView, _ indexPath:IndexPath) -> UITableViewCell) 
```


### 使用


> controller中的display方法

```
func display() {
    let display = TableViewDisplay(sectionsCallback: { (sections) in
        // 1.News
        sections.append(TableViewSectionDisplay(headerHeight: 45.0, footerHeight: 50.0, autoHeaderHeight: false, autoFooterHeight: false, viewForHeader: { (tableView, section) in
            let header = tableView?.headerFooter(nibClass: NewsListTableHeaderView.self) as! NewsListTableHeaderView
            header.lblName.text = "新闻列表"
            return header
        }, viewForFooter: { (tableView, section) in
            let footer = tableView?.headerFooter(nibClass: NewsListTableFooterView.self) as! NewsListTableFooterView
            footer.lblDesc.text = "上面是新闻"
            return footer
        }, rowsCallback: { (rows) in
            for (_, value) in (newsModel?.newslist!.enumerated())! {
                let row = TableViewRowDisplay(cellHeight: 60.0, autoCellHeight: true, cellForRowAt: { (tableView, indexPath) -> UITableViewCell in
                    let cell = tableView.cell(nibClass: NewsListTableViewCell.self) as! NewsListTableViewCell
                    cell.lblTitle.text = value.title
                    cell.lblSubTitle.text = value.source
                    return cell
                })
                rows.append(row)
            }
        }))
        // 2.Appliances
        sections.append(TableViewSectionDisplay(headerHeight: 90.0, footerHeight: CGFloat.leastNormalMagnitude, autoHeaderHeight: false, autoFooterHeight: false, viewForHeader: { (tableView, section) -> UIView in
            let header = tableView?.headerFooter(nibClass: AppliancesTableHeaderView.self) as! AppliancesTableHeaderView
            header.lblName.text = "这里的电器"
            return header
        }, viewForFooter: nil, rowsCallback: { (rows) in
            rows.append(TableViewRowDisplay(cellHeight: 100.0, autoCellHeight: false, cellForRowAt: { (tableView, indexPath) -> UITableViewCell in
                let cell = tableView.cell(nibClass: AppliancesTableViewCell.self) as! AppliancesTableViewCell
                cell.lblName.text = self.appliancesModel?.name
                cell.lblColor.text = self.appliancesModel?.color
                cell.lblPrice.text = "\(self.appliancesModel!.price)"
                return cell
            }))
        }))
        // 3. Animal & Person
        sections.append(TableViewSectionDisplay(headerHeight: 50.0, footerHeight: CGFloat.leastNormalMagnitude, autoHeaderHeight: false, autoFooterHeight: false, viewForHeader: nil, viewForFooter: nil, rowsCallback: { (rows) in
            rows.append(TableViewRowDisplay(cellHeight: self.tableView.bounds.size.width / 16.0 * 9.0, autoCellHeight: false, cellForRowAt: { (tableView, indexPath) -> UITableViewCell in
                let cell = tableView.cell(nibClass: AnimalTCell.self) as! AnimalTCell
                return cell
            }))
            rows.append(TableViewRowDisplay(cellHeight: 80.0, autoCellHeight: false, cellForRowAt: { (tableView, indexPath) -> UITableViewCell in
                let cell = tableView.cell(anyClass: PersonTCell.self) as! PersonTCell
                cell.lblName.text = "张三"
                return cell
            }))
        }))
    })
    self.secret = TableViewSecret(tableView: tableView, display: display)
    self.secret.didSelectRowAtIndexPath = {(tableView, indexPath)
        in
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
```

如上述，通过display的block回调，我们可以对tableView的具体实现控制。
需要注意的是，代码里的“_tvSecret”的生命周期需要和tableView的生命周期相同。这里创建的全局变量,防止tableView刷新时它的dataSource和delegate已经不存在,从而导致页面异常,具体的详情不做更多解读，欢迎去GitHub获取代码一探究竟，OC版本： [https://github.com/cba023/CBTableViewSecret](https://github.com/cba023/CBTableViewSecret) , Swift版本： [https://github.com/cba023/CBTableViewSecretSwifty](https://github.com/cba023/CBTableViewSecretSwifty)  。

### 总结
虽然这是一个良好的开始，但是我仍然意识到项目中还有很多的不足，比如针对UITableViewDelegate和UITableViewDataSource的方法调用还不够彻底，这个估计后期我会慢慢优化，期待CBTableViewSecret能够更加完善；同时代码中可能还有值得改善的地方，希望正在阅读此文的你能提出宝贵意见。
其实代码总体上很简单。艺术源于生活，而封装源于工作。不积跬步，无以至千里，祝愿彼此都能进步！
