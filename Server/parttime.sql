set names utf8;
DROP database if exists partTime;
create database partTime charset=utf8;
use partTime;

# 招聘信息列表
create table recruit_list(
	rlid int primary key auto_increment,      # 招聘信息列表id
  id int,                                   # id
  typeid int,                   
  rname varchar(128),                       # 招聘名称
  rsalary varchar(16),                      # 工资
  enterprise_name varchar(32),              # 企业名称
  salary_term varchar(16),                  # 工资结算期限
  area varchar(16),                         # 地区
  # 招聘详情
  position_detail varchar(1024),            # 职位详情
  start_time varchar(32),                   # 工作开始时间
  end_time varchar(32),                     # 工作结束时间
  contacts varchar(16),                     # 企业联系人
  issign int,              
  # 企业详情
  enterprise_icon varchar(64),              # 企业信息头像
  enterprise_detail varchar(1024),          # 企业信息概况
  enterprise_address varchar(64),           # 企业地址
  longitude decimal(10,7),                  # 经度
  latitude decimal(10,7),                   # 纬度
  # 筛选
  work_type varchar(32),                    # 类型
  sex_require varchar(8),                   # 性别要求,0-不限 1-男 2-女 
  time_interval varchar(8),                 # 上班时段,0不限 1上午 2下午 3晚上 
  work_cycle varchar(8)                     # 工作周期,0不限 1长期 2短期 3周末 
);

insert into recruit_list values(null,'1','100','手机小任务|在家做|日结躺赚','160元/天','广州指观网络科技有限公司','日结','历城区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon01.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.140011,36.678914,'销售','不限','不限','不限');
insert into recruit_list values(null,'2','100','全国高薪招募线上虎牙不露脸音频主播','160元/天','广州指观网络科技有限公司','日结','历下区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon02.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.125653,36.679792,'礼仪','男','上午','长期');
insert into recruit_list values(null,'3','200','济南校区上门一对一家教兼职','160元/天','广州指观网络科技有限公司','日结','高新区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon03.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.112623,36.675309,'家教导师','女','下午','短期');
insert into recruit_list values(null,'4','200','足不出户在家轻松躺赚','160元/天','广州指观网络科技有限公司','日结','市中区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon04.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.092564,36.685693,'派单','不限','上午','周末');
insert into recruit_list values(null,'5','100','手机小任务|在家做|日结躺赚','160元/天','广州指观网络科技有限公司','日结','历城区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon01.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.140011,36.678914,'销售','不限','不限','不限');
insert into recruit_list values(null,'6','100','全国高薪招募线上虎牙不露脸音频主播','160元/天','广州指观网络科技有限公司','日结','历下区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon02.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.125653,36.679792,'礼仪','男','上午','长期');
insert into recruit_list values(null,'7','200','济南校区上门一对一家教兼职','160元/天','广州指观网络科技有限公司','日结','高新区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon03.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.112623,36.675309,'家教导师','女','下午','短期');
insert into recruit_list values(null,'8','100','足不出户在家轻松躺赚','160元/天','广州指观网络科技有限公司','日结','市中区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon04.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.092564,36.685693,'派单','不限','上午','周末');
insert into recruit_list values(null,'9','200','手机小任务|在家做|日结躺赚','160元/天','广州指观网络科技有限公司','日结','历城区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon01.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.140011,36.678914,'销售','不限','不限','不限');
insert into recruit_list values(null,'10','200','全国高薪招募线上虎牙不露脸音频主播','160元/天','广州指观网络科技有限公司','日结','历下区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon02.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.125653,36.679792,'礼仪','男','上午','长期');
insert into recruit_list values(null,'11','100','济南校区上门一对一家教兼职','160元/天','广州指观网络科技有限公司','日结','高新区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon03.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.112623,36.675309,'家教导师','女','下午','短期');
insert into recruit_list values(null,'12','100','足不出户在家轻松躺赚','160元/天','广州指观网络科技有限公司','日结','市中区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon04.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.092564,36.685693,'派单','不限','上午','周末');
insert into recruit_list values(null,'13','100','足不出户在家轻松躺赚','160元/天','广州指观网络科技有限公司','日结','市中区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon04.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.092564,36.685693,'派单','不限','上午','周末');
insert into recruit_list values(null,'14','100','足不出户在家轻松躺赚','160元/天','广州指观网络科技有限公司','日结','市中区','[注意! ! ! ]:报名之后，无需等待!点击下方客服链接即可开始任务! ! !
[加入方式]
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCY]5d
客服链接: http://t.cn/A6zCYJ5d
[工作内容]
手机APP高薪兼职，做完微信结算，每天无限做，多劳多得，不限时间，不需要任何费用。(比如，抖音快手点赞，苏宁优惠券领取，都是非常简单而且轻松的任务)
[薪酬说明]
每成功完成一-个新任务的收入约1-50元不等(含自提，自提可在app内提现)。每个任务只需3- 10分钟左右即可完成,当天结算，微信或支付宝，不做任何拖欠，随时随地，手机在家兼职。
[工作时间]
客服小哥哥小姐姐基本全天在线，只要你有时间就可以随时点击链接找我们客服领取任务。
点击加入:
http://t.cn/A6zCY]5d
','3月22日','4月03日','陈经理',0,'/images/headericon04.png','天津达华广告有限公司成立于2019年12月17日，注册地位于天津自贸试验区(中心商务区)庆盛道以东、集智道以南绿城蓝色广场二栋1号楼-3034(天津煜美商务秘书服务有限公司托管第87号)，法定代表人为李达华。经营范围包括一般项目：广告发布（非广播电台、电视台、报刊出版单位）。','济南市历下区XXXXXX',117.092564,36.685693,'派单','不限','上午','周末');

# 信息标签
create table info_label(
  lid int primary key auto_increment,               # 信息标签id
  ilid int,                                         # 编号
  lcontent varchar(16),                             # 标签内容
  is_bgcolor boolean                                # 是否有背景色
);
insert into info_label values(null,'1','企业直招','1');
insert into info_label values(null,'1','在家','0');
insert into info_label values(null,'2','优质','1');
insert into info_label values(null,'2','热点招聘','0');
insert into info_label values(null,'3','在家','0');
insert into info_label values(null,'3','广告','0');
insert into info_label values(null,'4','广告','0');
insert into info_label values(null,'5','企业直招','1');
insert into info_label values(null,'5','在家','0');
insert into info_label values(null,'6','优质','1');
insert into info_label values(null,'6','热点招聘','0');
insert into info_label values(null,'7','在家','0');
insert into info_label values(null,'7','广告','0');
insert into info_label values(null,'8','广告','0');
insert into info_label values(null,'9','企业直招','1');
insert into info_label values(null,'9','在家','0');
insert into info_label values(null,'10','优质','1');
insert into info_label values(null,'10','热点招聘','0');
insert into info_label values(null,'11','在家','0');
insert into info_label values(null,'11','广告','0');
insert into info_label values(null,'12','广告','0');
insert into info_label values(null,'13','在家','0');
insert into info_label values(null,'13','广告','0');
insert into info_label values(null,'14','广告','0');

# 招聘要求
create table rec_require(
  rid int primary key auto_increment,               # 招聘要求id
  rrid int,                                         # 编号
  rcontent varchar(16)                              # 要求内容
);
insert into rec_require values(null,'1','完工结');
insert into rec_require values(null,'1','招30人');
insert into rec_require values(null,'1','男女不限');
insert into rec_require values(null,'2','日结');
insert into rec_require values(null,'2','招6人');
insert into rec_require values(null,'2','男女不限');
insert into rec_require values(null,'3','周结');
insert into rec_require values(null,'3','招10人');
insert into rec_require values(null,'3','男女不限');
insert into rec_require values(null,'4','日结');
insert into rec_require values(null,'4','招6人');
insert into rec_require values(null,'4','男女不限');
insert into rec_require values(null,'5','完工结');
insert into rec_require values(null,'5','招30人');
insert into rec_require values(null,'6','男女不限');
insert into rec_require values(null,'6','日结');
insert into rec_require values(null,'7','招6人');
insert into rec_require values(null,'7','男女不限');
insert into rec_require values(null,'8','周结');
insert into rec_require values(null,'9','招10人');
insert into rec_require values(null,'9','男女不限');
insert into rec_require values(null,'10','日结');
insert into rec_require values(null,'10','招6人');
insert into rec_require values(null,'10','男女不限');
insert into rec_require values(null,'11','完工结');
insert into rec_require values(null,'11','招30人');
insert into rec_require values(null,'12','男女不限');
insert into rec_require values(null,'12','日结');
insert into rec_require values(null,'12','招6人');
insert into rec_require values(null,'12','男女不限');
insert into rec_require values(null,'13','周结');
insert into rec_require values(null,'13','招10人');
insert into rec_require values(null,'13','男女不限');
insert into rec_require values(null,'14','日结');
insert into rec_require values(null,'14','招6人');
insert into rec_require values(null,'14','男女不限');

# 咨询情况
create table consult(
  cid int primary key auto_increment,               # 咨询情况id
  csid int,                                         # 编号
  jobhunter varchar(16),                            # 求职者名字
  ccontent varchar(256),                            # 内容
  is_recruiter boolean                              # 是否是招聘者
);
insert into consult values(null,'1','白佳帅','骗子 刷9单给工资 刷到第6单就不联系了','0');
insert into consult values(null,'1','白佳帅','骗子吗','0');
insert into consult values(null,'1','赵红卫','还要人吗','0');
insert into consult values(null,'1','成小函','你好工作还需要人吗','0');
insert into consult values(null,'2','李腾辉','你好，玩过配音，喜欢说唱','0');
insert into consult values(null,'3','陈戈','现在还需要吗','0');
insert into consult values(null,'3','李晴','现在还需要吗 我英语专业','0');
insert into consult values(null,'3','企业回复','需要的','1');
insert into consult values(null,'4','陈小猪','毕业两年可以吗','0');
insert into consult values(null,'4','企业回复','可以','1');


# 首页轮播图片
create table swiper_pic(
	pid int primary key auto_increment,       # 轮播图片id
  pic_url varchar(128)                      # 图片路径
);
insert into swiper_pic values(null,'/images/swiper01.png');
insert into swiper_pic values(null,'/images/swiper02.png');
insert into swiper_pic values(null,'/images/swiper03.png');


# 简历信息
create table resume_info(
  ild int primary key auto_increment,       # 简历信息id
  riid int,
  head_icon varchar(128),                   # 头像
  iname varchar(16),                        # 名字
  isex varchar(16),
  iage int,                                 # 年龄
  iarea varchar(128),                       # 所在地区
  iphone varchar(16),                       # 手机号
  ipwd varchar(16),                         # 密码
  iemail varchar(16),                       # 邮箱
  # 教育经历
  ischool varchar(16),                      # 学校
  imajor varchar(32),                       # 专业
  ieducation varchar(16),                   # 学历
  admission_date varchar(16),               # 入学时间
  graduation_date varchar(16),              # 毕业时间
  association_activity varchar(800),        # 在校经历
  # 工作经历
  enterprise_name varchar(16),              # 公司名称
  start_time varchar(32),                   # 工作开始时间
  end_time varchar(32),                     # 工作结束时间
  work_detail varchar(800),                 # 具体内容
  # 工作期望
  hope_type int,                            # 期望工作类型，1-短期 2-长期 3-周末 4不限
  hope_time int,                            # 期望工作时间，1-工作日 2-周末 3-寒暑假 4-不限
  # 自我评价
  self_assessment varchar(800)              # 自我评价
);
insert into resume_info values(null,1,'/images/headericon01.png','张三','男',23,'济南','13111111111','123456z','123456@163.com','山东大学','信息科学与技术','本科','2016.09','2020.07','','华夏良子','2019.04','2019.07','工作具体内容',4,4,'自我评价');
insert into resume_info values(null,2,'/images/headericon01.png','李四','男',23,'济南','13111111111','123456z','123456@163.com','山东大学','信息科学与技术','本科','2016.09','2020.07','','华夏良子','2019.04','2019.07','工作具体内容',4,4,'自我评价');
insert into resume_info values(null,3,'/images/headericon01.png','王五','男',23,'济南','13111111111','123456z','123456@163.com','山东大学','信息科学与技术','本科','2016.09','2020.07','','华夏良子','2019.04','2019.07','工作具体内容',4,4,'自我评价');
insert into resume_info values(null,4,'/images/headericon01.png','刘二','男',23,'济南','13111111111','123456z','123456@163.com','山东大学','信息科学与技术','本科','2016.09','2020.07','','华夏良子','2019.04','2019.07','工作具体内容',4,4,'自我评价');
insert into resume_info values(null,5,'/images/headericon01.png','张二','男',23,'济南','13111111111','123456z','123456@163.com','山东大学','信息科学与技术','本科','2016.09','2020.07','','华夏良子','2019.04','2019.07','工作具体内容',4,4,'自我评价');
insert into resume_info values(null,6,'/images/headericon01.png','李三','男',23,'济南','13111111111','123456z','123456@163.com','山东大学','信息科学与技术','本科','2016.09','2020.07','','华夏良子','2019.04','2019.07','工作具体内容',4,4,'自我评价');
insert into resume_info values(null,7,'/images/headericon01.png','王四','男',23,'济南','13111111111','123456z','123456@163.com','山东大学','信息科学与技术','本科','2016.09','2020.07','','华夏良子','2019.04','2019.07','工作具体内容',4,4,'自我评价');
insert into resume_info values(null,8,'/images/headericon01.png','刘五','男',23,'济南','13111111111','123456z','123456@163.com','山东大学','信息科学与技术','本科','2016.09','2020.07','','华夏良子','2019.04','2019.07','工作具体内容',4,4,'自我评价');
insert into resume_info values(null,9,'/images/headericon01.png','张思','男',23,'济南','13111111111','123456z','123456@163.com','山东大学','信息科学与技术','本科','2016.09','2020.07','','华夏良子','2019.04','2019.07','工作具体内容',4,4,'自我评价');
insert into resume_info values(null,10,'/images/headericon01.png','李武','男',23,'济南','13111111111','123456z','123456@163.com','山东大学','信息科学与技术','本科','2016.09','2020.07','','华夏良子','2019.04','2019.07','工作具体内容',4,4,'自我评价');
insert into resume_info values(null,11,'/images/headericon01.png','王柳','男',23,'济南','13111111111','123456z','123456@163.com','山东大学','信息科学与技术','本科','2016.09','2020.07','','华夏良子','2019.04','2019.07','工作具体内容',4,4,'自我评价');
insert into resume_info values(null,12,'/images/headericon01.png','刘三','男',23,'济南','13111111111','123456z','123456@163.com','山东大学','信息科学与技术','本科','2016.09','2020.07','','华夏良子','2019.04','2019.07','工作具体内容',4,4,'自我评价');
insert into resume_info values(null,13,'/images/headericon01.png','章武','男',23,'济南','13111111111','123456z','123456@163.com','山东大学','信息科学与技术','本科','2016.09','2020.07','','华夏良子','2019.04','2019.07','工作具体内容',4,4,'自我评价');

# 报名列表
create table sign_list(
  slid int primary key auto_increment,
  riid int,
  id int,
  issign int
);
insert into sign_list values(null,1,1,1);

# 聊天信息
create table msg_list(
  mlid int primary key auto_increment,
  riid int,
  id int,
  msg varchar(800),
  isenterprise int
);
insert into msg_list values(null,1,3,'哈哈哈哈',0);

# 管理员
create table admin_list(
  alid int primary key auto_increment,
  id int,
  aname varchar(16),
  apwd varchar(16)
);
insert into admin_list values(null,1,'admin','123456');