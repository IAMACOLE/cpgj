var LOTTERY_DETAIL= {
    //彩种类型1     时时彩
    LOTTERY_1: {
        num_min: 0,
        num_max: 9,
        num_len: 1,
        run_num_length: 5,
        wf_class: {
            wf_wx: {
                title: '五星',
                row: {
                    '五星直选': ['150001', '150030', '150031'],
                    '五星组选': ['150041', '150042', '150043', '150044', '150045', '150046'],
                    '五星特殊': ['150060', '150061', '150062', '150063', '150064']
                },
                150001: {     //五星直选复式
                    type: 'select',
                    param: {
                        titles: {ww: '万位', qw: '千位', bw: '百位', sw: '十位', ge: '个位'},
                        begin: 0,
                        end: 9,
                        row_num_count: 10,
                        selector: 2
                    },
                    calculate: {method: 'formula_num_multiply'},
                    explain: '从万位、千位、百位、十位、个位各选一个号码组成一注。',
                    example: '投注方案：12345<br>开奖号码：12345，即中五星直选。',
                    help: '从万位、千位、百位、十位、个位中选择一个5位数号码组成一注，所选号码与开奖号码相同，且顺序一致，即为中奖。'
                },
                150030: {     //五星直选单式
                    type: 'input',
                    param: {},
                    calculate: {base_len: 5, check_type: 0},
                    explain: '手动输入号码，至少输入1个五位数号码组成一注。',
                    example: '投注方案：23456<br>开奖号码：23456，即中五星直选。',
                    help: '手动输入一个5位数号码组成一注，所选号码的万位、千位、百位、十位、个位与开奖号码相同，且顺序一致，即为中奖。(五星直选单式每注的最大投注为10000注,如果确实想投注更多的号码，请拆分成多注后进行)'
                },
                150031: {     //五星组合
                    type: 'select',
                    param: {
                        titles: {ww: '万位', qw: '千位', bw: '百位', sw: '十位', ge: '个位'},
                        begin: 0,
                        end: 9,
                        row_num_count: 10,
                        selector: 2
                    },
                    calculate: {method: 'formula_group'},
                    explain: '从万位、千位、百位、十位、个位各选一个号码组成五注。',
                    example: '投注方案：<br/>购买：4+5+6+7+8，该票共10元，由以下5注：45678(五星)、5678(四星)、678(三星)、78(二星)、8(一星)构成。<br/>开奖号码：45678，即可中五星、四星、三星、二星、一星各1注。',
                    help: '从万位、千位、百位、十位、个位中至少各选一个号码组成1-5星的组合，共五注，所选号码的个位与开奖号码相同，则中1个5等奖；所选号码的个位、十位与开奖号码相同，则中1个5等奖以及1个4等奖，依此类推，最高可中5个奖。'
                },
                150041: {     //组选120
                    type: 'select',
                    param: {titles: {zx: '组选120'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 5},
                    explain: '从0-9中选择5个号码组成一注。',
                    example: '投注方案：10568<br/>开奖号码：10568（顺序不限），即可中五星组选120。',
                    help: '从0-9中任意选择5个号码组成一注，所选号码与开奖号码的万位、千位、百位、十位、个位相同，顺序不限，即为中奖。'
                },
                150042: {     //组选60
                    type: 'select',
                    param: {titles: {er: '二重号', dan: '单号'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_one_more', oneRow: 0, moreRow: 1, base_len: 3},
                    explain: '从“二重号”选择一个号码，“单号”中选择三个号码组成一注。',
                    example: '投注方案：二重号：8；单号：016<br/>开奖号码：01688（顺序不限），即可中五星组选60。',
                    help: '选择1个二重号码和3个单号号码组成一注，所选的单号号码与开奖号码相同，且所选二重号码在开奖号码中出现了2次，即为中奖。'
                },
                150043: {     //组选30
                    type: 'select',
                    param: {titles: {er: '二重号', dan: '单号'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_one_more', oneRow: 1, moreRow: 0, base_len: 2},
                    explain: '从“二重号”选择两个号码，“单号”中选择一个号码组成一注。',
                    example: '投注方案：二重号：68；单号：0<br/>开奖号码：06688（顺序不限），即可中五星组选30。',
                    help: '选择2个二重号和1个单号号码组成一注，所选的单号号码与开奖号码相同，且所选的2个二重号码分别在开奖号码中出现了2次，即为中奖。'
                },
                150044: {     //组选20
                    type: 'select',
                    param: {
                        'titles': {san: '三重号', dan: '单号'},
                        begin: 0,
                        end: 9,
                        row_num_count: 10,
                        selector: 2
                    },
                    calculate: {method: 'formula_zx_one_more', oneRow: 0, moreRow: 1, base_len: 2},
                    explain: '从“三重号”选择一个号码，“单号”中选择两个号码组成一注。',
                    example: '投注方案：三重号：8；单号：01<br/>开奖号码：01888（顺序不限），即可中五星组选20。',
                    help: '选择1个三重号码和2个单号号码组成一注，所选的单号号码与开奖号码相同，且所选三重号码在开奖号码中出现了3次，即为中奖。'
                },
                150045: {     //组选10
                    type: 'select',
                    param: {titles: {san: '三重号', er: '二重号'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_one_more', oneRow: 0, moreRow: 1, base_len: 1},
                    explain: '从“三重号”选择一个号码，“二重号”中选择一个号码组成一注。',
                    example: '投注方案：三重号：8；二重号：1<br/>开奖号码：11888（顺序不限），即可中五星组选10。',
                    help: '选择1个三重号码和1个二重号码，所选三重号码在开奖号码中出现3次，并且所选二重号码在开奖号码中出现了2次，即为中奖。'
                },
                150046: {     //组选5
                    type: 'select',
                    param: {titles: {si: '四重号', dan: '单号'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_one_more', oneRow: 0, moreRow: 1, base_len: 1},
                    explain: '从“四重号”选择一个号码，“单号”中选择一个号码组成一注。',
                    example: '投注方案：四重号：8；单号：1<br/>开奖号码：18888（顺序不限），即可中五星组选5。',
                    help: '选择1个四重号码和1个单号号码组成一注，所选的单号存在于开奖号码中，且所选四重号码在开奖号码中出现了4次，即为中奖。'
                },
                150061: {     //一帆风顺
                    type: 'select',
                    param: {titles: {yi: '一帆风顺'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_num_count'},
                    explain: '从0-9中任意选择一个以上号码。',
                    example: '投注方案：8<br/>开奖号码：至少出现1个8，即中一帆风顺。',
                    help: '从0-9中任意选择1个号码组成一注，只要开奖号码的万位、千位、百位、十位、个位中包含所选号码，即为中奖。'
                },
                150062: {     //好事成双
                    type: 'select',
                    param: {titles: {hao: '好事成双'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_num_count'},
                    explain: '从0-9中任意选择一个以上的二重号码。',
                    example: '投注方案：8<br/>开奖号码：至少出现2个8，即中好事成双。',
                    help: '从0-9中任意选择1个号码组成一注，只要所选号码在开奖号码的万位、千位、百位、十位、个位中出现2次，即为中奖。'
                },
                150063: {     //三星报喜
                    type: 'select',
                    param: {titles: {san: '三星报喜'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_num_count'},
                    explain: '从0-9中任意选择一个以上的三重号码。',
                    example: '投注方案：8<br/>开奖号码：至少出现3个8，即中三星报喜。',
                    help: '从0-9中任意选择1个号码组成一注，只要所选号码在开奖号码的万位、千位、百位、十位、个位中出现3次，即为中奖。'
                },
                150064: {     //四季发财
                    type: 'select',
                    param: {titles: {si: '四季发财'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_num_count'},
                    explain: '从0-9中任意选择一个以上的四重号码。',
                    example: '投注方案：8<br/>开奖号码：至少出现4个8，即中四季发财。',
                    help: '从0-9中任意选择1个号码组成一注，只要所选号码在开奖号码的万位、千位、百位、十位、个位中出现4次，即为中奖。'
                },
                150060: {     //百家乐
                    type: 'select',
                    param: {titles: {banker: '庄', xian: '闲'}, cs: 'bjl', selector: 1},
                    calculate: {method: 'formula_num_count'},
                    explain: '任意选择一个号码组成一注。',
                    example: '百家乐',
                    help: '百家乐'
                }
            },
            wf_sx: {
                title: '四星',
                row: {
                    '四星直选': ['140402', '140401', '140431', '141502', '141501', '141531'],
                    '四星组选': ['140441', '140442', '140443', '140444', '141541', '141542', '141543', '141544']
                },
                140401: {   //前四直选单式
                    type: 'input',
                    param: {},
                    calculate: {base_len: 4, check_type: 0},
                    'explain': '手动输入号码，至少输入1个四位数号码组成一注。',
                    'example': '投注方案：3456<br/>开奖号码：3456，即中四星直选。',
                    'help': '手动输入一个4位数号码组成一注，所选号码的万位、千位、百位、十位与开奖号码相同，且顺序一致，即为中奖。'
                },
                140402: {   //前四直选复式
                    type: 'select',
                    param: {
                        titles: {ww: '万位', qw: '千位', bw: '百位', sw: '十位'},
                        begin: 0,
                        end: 9,
                        row_num_count: 10,
                        selector: 2
                    },
                    calculate: {method: 'formula_num_multiply'},
                    explain: '从万位、千位、百位、十位各选一个号码组成一注。',
                    example: '投注方案：3456<br/>开奖号码：3456，即中四星直选。',
                    help: '从万位、千位、百位、十位中选择一个4位数号码组成一注，所选号码与开奖号码相同，且顺序一致，即为中奖。'
                },
                140431: {   //前四直选组合
                    type: 'select',
                    param: {
                        titles: {ww: '万位', qw: '千位', bw: '百位', sw: '十位'},
                        begin: 0,
                        end: 9,
                        row_num_count: 10,
                        selector: 2
                    },
                    calculate: {method: 'formula_group'},
                    explain: '从万位、千位、百位、十位各选一个号码组成四注。',
                    example: '投注方案：<br/>购买：5+6+7+8，该票共8元，由以下4注：5678(四星)、678(三星)、78(二星)、8(一星)构成。<br/>开奖号码：5678，即可中四星、三星、二星、一星各1注。',
                    help: '从万位、千位、百位、十位中至少各选一个号码组成1-4星的组合，共四注，所选号码的个位与开奖号码相同，则中1个4等奖；所选号码的十位、百位与开奖号码相同，则中1个4等奖以及1个3等奖，依此类推，最高可中4个奖。'
                },
                141502: {     //后四直选复式
                    type: 'select',
                    param: {
                        titles: {qw: '千位', bw: '百位', sw: '十位', ge: '个位'},
                        begin: 0,
                        end: 9,
                        row_num_count: 10,
                        selector: 2
                    },
                    calculate: {method: 'formula_num_multiply'},
                    explain: '从千位、百位、十位、个位各选一个号码组成一注。',
                    example: '投注方案：3456<br/>开奖号码：3456，即中四星直选。',
                    help: '从千位、百位、十位、个位中选择一个4位数号码组成一注，所选号码与开奖号码相同，且顺序一致，即为中奖。'
                },
                141501: {     //后四直选单式
                    type: 'input',
                    param: {},
                    calculate: {base_len: 4, check_type: 0},
                    'explain': '手动输入号码，至少输入1个四位数号码组成一注。',
                    'example': '投注方案：3456<br/>开奖号码：3456，即中四星直选。',
                    'help': '手动输入一个4位数号码组成一注，所选号码的千位、百位、十位、个位与开奖号码相同，且顺序一致，即为中奖。'
                },
                141531: {     //后四直选组合
                    type: 'select',
                    param: {
                        titles: {qw: '千位', bw: '百位', sw: '十位', ge: '个位'},
                        begin: 0,
                        end: 9,
                        row_num_count: 10,
                        selector: 2
                    },
                    calculate: {method: 'formula_group'},
                    explain: '从千位、百位、十位、个位各选一个号码组成四注。',
                    example: '投注方案：<br/>购买：5+6+7+8，该票共8元，由以下4注：5678(四星)、678(三星)、78(二星)、8(一星)构成。<br/>开奖号码：5678，即可中四星、三星、二星、一星各1注。',
                    help: '从千位、百位、十位、个位中至少各选一个号码组成1-4星的组合，共四注，所选号码的个位与开奖号码相同，则中1个4等奖；所选号码的个位、十位与开奖号码相同，则中1个4等奖以及1个3等奖，依此类推，最高可中4个奖。'
                },
                140441: {     //前四组选24
                    type: 'select',
                    param: {titles: {zx: '组选24'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 4},
                    explain: '从0-9中选择4个号码组成一注。',
                    example: '投注方案：0568，开奖号码的四个数字只要包含0、5、6、8，即可中四星组选24。',
                    help: '从0-9中任意选择4个号码组成一注，所选号码与开奖号码的万位、千位、百位、十位相同，且顺序不限，即为中奖。'
                },
                140442: {     //前四组选12
                    type: 'select',
                    param: {titles: {er: '二重号', dan: '单号'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_one_more', oneRow: 0, moreRow: 1, base_len: 2},
                    explain: '从“二重号”选择一个号码，“单号”中选择两个号码组成一注。',
                    example: '投注方案：二重号：8，单号：0、6，只要开奖的四个数字从小到大排列为 0、6、8、8，即可中四星组选12。',
                    help: '选择1个二重号码和2个单号号码组成一注，所选号码与开奖号码的万位、千位、百位、十位相同，且所选二重号码在开奖号码万位、千位、百位、十位中出现了2次，即为中奖。'
                },
                140443: {     //前四组选6
                    type: 'select',
                    param: {titles: {er: '二重号'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 2},
                    explain: '从“二重号”选择两个号码组成一注。',
                    example: '投注方案：二重号：2、8，只要开奖的四个数字从小到大排列为 0、2、2、8、8，即可中四星组选6。',
                    help: '选择2个二重号码组成一注，所选的2个二重号码在开奖号码万位、千位、百位、十位分别出现了2次，即为中奖。'
                },
                140444: {     //前四组选4
                    type: 'select',
                    param: {titles: {san: '三重号', dan: '单号'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_one_more', oneRow: 0, moreRow: 1, base_len: 1},
                    explain: '从“三重号”选择一个号码，“单号”中选择一个号码组成一注。',
                    example: '投注方案：三重号：8，单号：0、2，只要开奖的四个数字从小到大排列为 0、2、8、8、8，即可中四星组选4。',
                    help: '选择1个三重号码和1个单号号码组成一注，所选号码与开奖号码的万位、千位、百位、十位相同，且所选三重号码在开奖号码万位、千位、百位、十位中出现了3次，即为中奖。'
                },
                141541: {     //后四组选24
                    type: 'select',
                    param: {titles: {zx: '组选24'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 4},
                    explain: '从0-9中选择4个号码组成一注。',
                    example: '投注方案：0568，开奖号码的四个数字只要包含0、5、6、8，即可中四星组选24。',
                    help: '从0-9中任意选择4个号码组成一注，所选号码与开奖号码的千位、百位、十位、个位相同，且顺序不限，即为中奖。'
                },
                141542: {     //后四组选12
                    type: 'select',
                    param: {titles: {er: '二重号', dan: '单号'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_one_more', oneRow: 0, moreRow: 1, base_len: 2},
                    explain: '从“二重号”选择一个号码，“单号”中选择两个号码组成一注。',
                    example: '投注方案：二重号：8，单号：0、6，只要开奖的四个数字从小到大排列为 0、6、8、8，即可中四星组选12。',
                    help: '选择1个二重号码和2个单号号码组成一注，所选号码与开奖号码的千位、百位、十位、个位相同，且所选二重号码在开奖号码千位、百位、十位、个位中出现了2次，即为中奖。'
                },
                141543: {     //后四组选6
                    type: 'select',
                    param: {titles: {er: '二重号'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 2},
                    explain: '从“二重号”选择两个号码组成一注。',
                    example: '投注方案：二重号：2、8，只要开奖的四个数字从小到大排列为 0、2、2、8、8，即可中四星组选6。',
                    help: '选择2个二重号码组成一注，所选的2个二重号码在开奖号码千位、百位、十位、个位分别出现了2次，即为中奖。'
                },
                141544: {     //后四组选4
                    type: 'select',
                    param: {titles: {san: '三重号', dan: '单号'}, begin: 0, end: 9, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_one_more', oneRow: 0, moreRow: 1, base_len: 1},
                    explain: '从“三重号”选择一个号码，“单号”中选择一个号码组成一注。',
                    example: '投注方案：三重号：8，单号：0、2，只要开奖的四个数字从小到大排列为 0、2、8、8、8，即可中四星组选4。',
                    help: '选择1个三重号码和1个单号号码组成一注，所选号码与开奖号码的千位、百位、十位、个位相同，且所选三重号码在开奖号码千位、百位、十位、个位中出现了3次，即为中奖。'
                }
            },
            'wf_qs': {
                title: '前三',
                row: {
                    '前三直选': ['17', '18', '130331', '130308', '130332'],
                    '前三组选': ['20', '21', '22', '23', '130307', '130339', '130333']/*,
                     '前三其他' : ['hezhiweishu','teshuhao']*/
                },
                '17': {     //前三直选复式
                    'type': 'select',
                    'param': {
                        'titles': {ww: '万位', qw: '千位', bw: '百位'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从万位、千位、百位各选一个号码组成一注。',
                    'example': '投注方案：345<br/>开奖号码：345，即中前三直选。',
                    'help': '从万位、千位、百位中选择一个3位数号码组成一注，所选号码与开奖号码的前3位相同，且顺序一致，即为中奖。'
                },
                '18': {     //前三直选单式
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 3, 'check_type': 0},
                    'explain': '手动输入号码，至少输入1个三位数号码组成一注。',
                    'example': '投注方案：345<br/>开奖号码：345，即中前三直选。',
                    'help': '手动输入一个3位数号码组成一注，所选号码的万位、千位、百位与开奖号码相同，且顺序一致，即为中奖。'
                },
                '130331': {     //前三组选混合
                    'type': 'select',
                    'param': {
                        'titles': {ww: '万位', qw: '千位', bw: '百位'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_group'},
                    'explain': '从万位、千位、百位各选一个号码组成三注。',
                    'example': '投注方案：<br/>购买：6+7+8，该票共6元，由以下3注：678(三星)、78(二星)、8(一星)构成<br/>开奖号码：678，即可中三星、二星、一星各1注。',
                    'help': '从万位、千位、百位中至少各选择一个号码组成1-3星的组合共三注，当百位号码与开奖号码相同，则中1个3等奖；如果百位与千位号码与开奖号码相同，则中1个3等奖以及1个2等奖，依此类推，最高可中3个奖。'
                },
                '130308': {     //前三直选和值
                    'type': 'select',
                    'param': {'titles': {zhi: '和值'}, 'begin': 0, 'end': 27, 'row_num_count': 14, 'selector': 0},
                    'calculate': {'method': 'formula_value_add', 'value': 'zhi_san', num_separator: '$'},
                    'explain': '从0-27中任意选择一个或一个以上号码。',
                    'example': '投注方案：和值1<br/>开奖号码前三位：001,010,100,即中前三直选。',
                    'help': '所选数值等于开奖号码的万位、千位、百位三个数字相加之和，即为中奖。'
                },
                '130332': {     //前三直选跨度
                    'type': 'select',
                    'param': {'titles': {zhi: '跨度'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_value_add', 'value': 'kd_san', num_separator: ','},
                    'explain': '从0-9中选择一个或一个以上号码。',
                    'example': '投注方案：跨度8<br/>开奖号码前三位：(1)开出的三个数字包括0,8,x，其中x≠9，即可中前三直选;(2)开出的三个数字包括1,9,x，其中x≠0，即可中前三直选。',
                    'help': '所选数值等于开奖号码的前3位最大与最小数字相减之差，即为中奖。'
                },
                '20': {     //前三组三复式
                    'type': 'select',
                    'param': {
                        'titles': {zs_fs: '组三'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_num_fold', 'base_len': 2},
                    'explain': '从0-9中任意选择2个或2个以上号码。',
                    'example': '投注方案：5,8,8<br/>开奖号码前三位：1个5，2个8 (顺序不限)，即中前三组三。',
                    'help': '从0-9中选择2个数字组成两注，所选号码与开奖号码的万位、千位、百位相同，且顺序不限，即为中奖。'
                },
                '21': {     //前三组三单式
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 3, 'check_type': 4},
                    'explain': '手动输入号码，至少输入1个三位数号码（三个数字中必须有二个数字相同）。',
                    'example': '投注方案：5,8,8<br/>开奖号码前三位：1个5，2个8 (顺序不限)，即中前三组三。',
                    'help': '从0-9中选择2个数字组成两注，所选号码与开奖号码的万位、千位、百位相同，且顺序不限，即为中奖。'
                },
                '22': {     //前三组六复式
                    'type': 'select',
                    'param': {
                        'titles': {zl_fs: '组六'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_zx_fs', 'base_len': 3},
                    'explain': '从0-9中任意选择3个或3个以上号码。',
                    'example': '投注方案：2,5,8<br/>开奖号码前三位：1个2、1个5、1个8 (顺序不限)，即中前三组六。',
                    'help': '从0-9中任意选择3个号码组成一注，所选号码与开奖号码的万位、千位、百位相同，顺序不限，即为中奖。'
                },
                '23': {     //前三组六单式
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 3, 'check_type': 1},
                    'explain': '手动输入号码，至少输入1个三位数号码（三个数字完全不相同）。',
                    'example': '投注方案：2,5,8<br/>开奖号码前三位：1个2、1个5、1个8 (顺序不限)，即中前三组六。',
                    'help': '从0-9中任意选择3个号码组成一注，所选号码与开奖号码的万位、千位、百位相同，顺序不限，即为中奖。'
                },
                '130307': {     //前三混合组选
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 3, 'check_type': 3},
                    'explain': '手动输入号码，至少输入1个三位数号码。',
                    'example': '投注方案：分別投注(0,0,1),以及(1,2,3)<br/>开奖号码前三位包括：(1)0,0,1，顺序不限，即中得前三组三；或者(2)1,2,3，顺序不限，即中得前三组六。',
                    'help': '手动输入一个3位数号码组成一注(不含豹子号)，开奖号码的万位、千位、百位符合后三组三或组六均为中奖。'
                },
                '130339': {     //前三组选和值
                    'type': 'select',
                    'param': {'titles': {zx: '和值'}, 'begin': 1, 'end': 26, 'row_num_count': 13, 'selector': 0},
                    'calculate': {'method': 'formula_value_add', 'value': 'zu_san', num_separator: '$'},
                    'explain': '从1-26中任意选择一个或一个以上号码。',
                    'example': '投注方案：和值3<br/>开奖号码前三位：(1)开出003号码，顺序不限，即中前三组三；(2)开出012号码，顺序不限，即中前三组六。',
                    'help': '所选数值等于开奖号码万位、千位、百位三个数字相加之和(不含豹子号)，即为中奖。'
                },
                '130333': {     //前三组选包胆
                    'type': 'select',
                    'param': {'titles': {zx: '包胆'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_count_fold', 'bet': '54', num_separator: '$'},
                    'explain': '从0-9中任意选择一个号码。',
                    'example': '投注方案：包胆3<br/>开奖号码前三位：(1)出现3xx或者33x,即中前三组三；(2)出现3xy，即中前三组六。',
                    'help': '从0-9中任意选择1个包胆号码，开奖号码的万位、千位、百位中任意1位只要和所选包胆号码相同(不含豹子号)，即为中奖。'
                },
                'qs_hz_ws': {     //前三和值尾数
                    'type': 'select',
                    'param': {
                        'titles': {hz_ws: '和值尾数'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从0-9中任意选择一个或一个以上号码。',
                    'example': '投注方案：和值尾数8<br/>开奖号码：前三位和值尾数为8，即中得和值尾数。',
                    'help': '所选数值等于开奖号码的万位、千位、百位三个数字相加之和的尾数，即为中奖。'
                },
                'qs_ts': {       //前三特殊号
                    'type': 'select',
                    'param': {'titles': {tsh: '特殊号'}, 'cs': 'tsh', 'selector': 0},
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '选择一个号码形态。',
                    'example': '投注方案：豹子<br/>开奖号码前三位：三个数字全部相同，即中得豹子。<br/>投注方案：顺子<br/>开奖号码前三位：为连续数字，例如678，即中得顺子。<br/>投注方案：对子<br/>开奖号码前三位：3个数字中有2个数字相同，即中得对子。',
                    'help': '所选的号码特殊属性和开奖号码前3位的属性一致，即为中奖。其中：1.顺子号的万、千、百位不分顺序(特别号码：019、089也是顺子号)；2.对子号指的是开奖号码的前三位当中，任意2位数字相同的三位数号码。'
                }
            },
            'wf_zs': {
                title: '中三',
                row: {
                    '中三直选': ['131402', '131401', '131431', '131408', '131432'],
                    '中三组选': ['131404', '131403', '131406', '131405', '150065', '131439', '131433']
                },
                '131402': {      //中三直选复式
                    'type': 'select',
                    'param': {
                        'titles': {qw: '千位', bw: '百位', sw: '十位'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从千位、百位、十位各选一个号码组成一注。',
                    'example': '投注方案：345<br/>开奖号码：345，即中中三直选。',
                    'help': '从千位、百位、十位中选择一个3位数号码组成一注，所选号码与开奖号码后3位相同，且顺序一致，即为中奖。'
                },
                '131401': {      //中三直选单式
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 3, 'check_type': 0},
                    'explain': '手动输入号码，至少输入1个三位数号码组成一注。',
                    'example': '投注方案：345<br/>开奖号码：345，即中中三直选。',
                    'help': '手动输入一个3位数号码组成一注，所选号码的千位、百位、十位与开奖号码相同，且顺序一致，即为中奖。'
                },
                '132531': {     //中三组选混合
                    'type': 'select',
                    'param': {
                        'titles': {qw: '千位', bw: '百位', sw: '十位'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_group'},
                    'explain': '从千位、百位、十位各选一个号码组成三注。',
                    'example': '投注方案：<br/>购买：6+7+8，该票共6元，由以下3注：678(三星)、78(二星)、8(一星)构成<br/>开奖号码：678，即可中三星、二星、一星各1注。',
                    'help': '从千位、百位、十位中至少各选择一个号码组成1-3星的组合共三注，当个位号码与开奖号码相同，则中1个3等奖；如果个位与十位号码与开奖号码相同，则中1个3等奖以及1个2等奖，依此类推，最高可中3个奖。'
                },
                '150065': {     //中三组选混合
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 3, 'check_type': 3},
                    'explain': '手动输入号码，至少输入1个三位数号码。',
                    'example': '投注方案：分別投注(0,0,1),以及(1,2,3)<br/>开奖号码后三位包括：(1)0,0,1，顺序不限，即中得中三组三；或者(2)1,2,3，顺序不限，即中得中三组六。',
                    'help': '手动输入一个3位数号码组成一注(不含豹子号)，开奖号码的千位、百位、十位符合后三组三或组六均为中奖。'
                },
                '131408': {      //中三直选和值
                    'type': 'select',
                    'param': {'titles': {zhi: '和值'}, 'begin': 0, 'end': 27, 'row_num_count': 14, 'selector': 0},
                    'calculate': {'method': 'formula_value_add', 'value': 'zhi_san', num_separator: '$'},
                    'explain': '从0-27中任意选择一个或一个以上号码。',
                    'example': '投注方案：和值1<br/>开奖号码中三位：001,010,100,即中中三直选。',
                    'help': '所选数值等于开奖号码的千位、百位、十位三个数字相加之和，即为中奖。'
                },
                '131404': {      //中三组三复式
                    'type': 'select',
                    'param': {
                        'titles': {zs_fs: '组三'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_num_fold', 'base_len': 2},
                    'explain': '从0-9中任意选择2个或2个以上号码。',
                    'example': '投注方案：5,8,8<br/>开奖号码中三位：1个5，2个8 (顺序不限)，即中中三组三。',
                    'help': '从0-9中选择2个数字组成两注，所选号码与开奖号码的千位、百位、十位相同，且顺序不限，即为中奖。'
                },
                '131403': {      //中三组三单式
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 3, 'check_type': 4},
                    'explain': '手动输入号码，至少输入1个三位数号码（三个数字中必须有二个数字相同）。',
                    'example': '投注方案：5,8,8<br/>开奖号码中三位：1个5，2个8 (顺序不限)，即中中三组三。',
                    'help': '从0-9中选择2个数字组成两注，所选号码与开奖号码的千位、百位、十位相同，且顺序不限，即为中奖。'
                },
                '131406': {      //中三组六复式
                    'type': 'select',
                    'param': {
                        'titles': {zl_fs: '组六'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_zx_fs', 'base_len': 3},
                    'explain': '从0-9中任意选择3个或3个以上号码。',
                    'example': '投注方案：2,5,8<br/>开奖号码中三位：1个2、1个5、1个8 (顺序不限)，即中中三组六。',
                    'help': '从0-9中任意选择3个号码组成一注，所选号码与开奖号码的千位、百位、十位相同，顺序不限，即为中奖。'
                },
                '131405': {      //中三组六单式
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 3, 'check_type': 1},
                    'explain': '手动输入号码，至少输入1个三位数号码（三个数字完全不相同）。',
                    'example': '投注方案：2,5,8<br/>开奖号码中三位：1个2、1个5、1个8 (顺序不限)，即中中三组六。',
                    'help': '从0-9中任意选择3个号码组成一注，所选号码与开奖号码的千位、百位、十位相同，顺序不限，即为中奖。'
                },
                '131439': {     //中三组选和值
                    'type': 'select',
                    'param': {'titles': {zx: '和值'}, 'begin': 1, 'end': 26, 'row_num_count': 13, 'selector': 0},
                    'calculate': {'method': 'formula_value_add', 'value': 'zu_san', num_separator: '$'},
                    'explain': '从1-26中任意选择一个或一个以上号码。',
                    'example': '投注方案：和值3<br/>开奖号码中三位：(1)开出003号码，顺序不限，即中中三组三；(2)开出012号码，顺序不限，即中中三组六。',
                    'help': '所选数值等于开奖号码千位、百位、十位三个数字相加之和(不含豹子号)，即为中奖。'
                },
                '131433': {     //中三组选包胆
                    'type': 'select',
                    'param': {'titles': {zx: '包胆'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_count_fold', 'bet': '54', num_separator: '$'},
                    'explain': '从0-9中任意选择一个号码。',
                    'example': '投注方案：包胆3<br/>开奖号码中三位：(1)出现3xx或者33x,即中中三组三；(2)出现3xy，即中中三组六。',
                    'help': '从0-9中任意选择1个包胆号码，开奖号码的千位、百位、十位中任意1位与所选包胆号码相同(不含豹子号)，即为中奖。'
                },
                '131431': {    //中三直选混合
                    'type': 'select',
                    'param': {
                        'titles': {qw: '千位', bw: '百位', sw: '十位'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_group'},
                    'explain': '从千位、百位、十位各选一个号码组成三注。',
                    'example': '投注方案：<br/>购买：6+7+8，该票共6元，由以下3注：678(三星)、78(二星)、8(一星)构成<br/>开奖号码：678，即可中三星、二星、一星各1注。',
                    'help': '从千位、百位、十位中至少各选择一个号码组成1-3星的组合共三注，当百位号码与开奖号码相同，则中1个3等奖；如果百位与千位号码与开奖号码相同，则中1个3等奖以及1个2等奖，依此类推，最高可中3个奖。'
                },
                '131432': {     //中三直选跨度
                    'type': 'select',
                    'param': {'titles': {zhi: '跨度'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_value_add', 'value': 'kd_san', num_separator: ','},
                    'explain': '从0-9中选择一个以上号码。',
                    'example': '投注方案：跨度8<br/>开奖号码中间三位：(1)开出的三个数字包括0,8,x，其中x≠9，即可中中三直选;(2)开出的三个数字包括1,9,x，其中x≠0，即可中中三直选。',
                    'help': '所选数值等于开奖号码的中间3位最大与最小数字相减之差，即为中奖。'
                }
            },
            'wf_hs': {
                title: '后三',
                row: {
                    '后三直选': ['2', '3', '132531', '8', '132532'],
                    '后三组选': ['4', '5', '6', '7', '132407', '132539', '132533']/*,
                     '后三其他' : ['hezhiweishu','teshuhao']*/
                },
                '2': {      //后三直选复式
                    'type': 'select',
                    'param': {
                        'titles': {bw: '百位', sw: '十位', ge: '个位'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从百位、十位、个位各选一个号码组成一注。',
                    'example': '投注方案：345<br/>开奖号码：345，即中后三直选。',
                    'help': '从百位、十位、个位中选择一个3位数号码组成一注，所选号码与开奖号码后3位相同，且顺序一致，即为中奖。'
                },
                '3': {      //后三直选单式
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 3, 'check_type': 0},
                    'explain': '手动输入号码，至少输入1个三位数号码组成一注。',
                    'example': '投注方案：345<br/>开奖号码：345，即中后三直选。',
                    'help': '手动输入一个3位数号码组成一注，所选号码的百位、十位、个位与开奖号码相同，且顺序一致，即为中奖。'
                },
                '132531': {     //后三组选混合
                    'type': 'select',
                    'param': {
                        'titles': {bw: '百位', sw: '十位', ge: '个位'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_group'},
                    'explain': '从百位、十位、个位各选一个号码组成三注。',
                    'example': '投注方案：<br/>购买：6+7+8，该票共6元，由以下3注：678(三星)、78(二星)、8(一星)构成<br/>开奖号码：678，即可中三星、二星、一星各1注。',
                    'help': '从百位、十位、个位中至少各选择一个号码组成1-3星的组合共三注，当个位号码与开奖号码相同，则中1个3等奖；如果个位与十位号码与开奖号码相同，则中1个3等奖以及1个2等奖，依此类推，最高可中3个奖。'
                },
                '8': {      //后三直选和值
                    'type': 'select',
                    'param': {'titles': {zhi: '和值'}, 'begin': 0, 'end': 27, 'row_num_count': 14, 'selector': 0},
                    'calculate': {'method': 'formula_value_add', 'value': 'zhi_san', num_separator: '$'},
                    'explain': '从0-27中任意选择一个或一个以上号码。',
                    'example': '投注方案：和值1<br/>开奖号码后三位：001,010,100,即中后三直选。',
                    'help': '所选数值等于开奖号码的百位、十位、个位三个数字相加之和，即为中奖。'
                },
                '132532': {     //后三直选跨度
                    'type': 'select',
                    'param': {'titles': {zhi: '跨度'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_value_add', 'value': 'kd_san', num_separator: ','},
                    'explain': '从0-9中选择一个以上号码。',
                    'example': '投注方案：跨度8<br/>开奖号码后三位：(1)开出的三个数字包括0,8,x，其中x≠9，即可中后三直选;(2)开出的三个数字包括1,9,x，其中x≠0，即可中后三直选。',
                    'help': '所选数值等于开奖号码的后3位最大与最小数字相减之差，即为中奖。'
                },
                '4': {      //后三组三复式
                    'type': 'select',
                    'param': {
                        'titles': {zs_fs: '组三'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_num_fold', 'base_len': 2},
                    'explain': '从0-9中任意选择2个或2个以上号码。',
                    'example': '投注方案：5,8,8<br/>开奖号码后三位：1个5，2个8 (顺序不限)，即中后三组三。',
                    'help': '从0-9中选择2个数字组成两注，所选号码与开奖号码的百位、十位、个位相同，且顺序不限，即为中奖。'
                },
                '5': {      //后三组三单式
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 3, 'check_type': 4},
                    'explain': '手动输入号码，至少输入1个三位数号码（三个数字中必须有二个数字相同）。',
                    'example': '投注方案：5,8,8<br/>开奖号码后三位：1个5，2个8 (顺序不限)，即中后三组三。',
                    'help': '从0-9中选择2个数字组成两注，所选号码与开奖号码的百位、十位、个位相同，且顺序不限，即为中奖。'
                },
                '6': {      //后三组六复式
                    'type': 'select',
                    'param': {
                        'titles': {zl_fs: '组六'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_zx_fs', 'base_len': 3},
                    'explain': '从0-9中任意选择3个或3个以上号码。',
                    'example': '投注方案：2,5,8<br/>开奖号码后三位：1个2、1个5、1个8 (顺序不限)，即中后三组六。',
                    'help': '从0-9中任意选择3个号码组成一注，所选号码与开奖号码的百位、十位、个位相同，顺序不限，即为中奖。'
                },
                '7': {      //后三组六单式
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 3, 'check_type': 1},
                    'explain': '手动输入号码，至少输入1个三位数号码（三个数字完全不相同）。',
                    'example': '投注方案：2,5,8<br/>开奖号码后三位：1个2、1个5、1个8 (顺序不限)，即中后三组六。',
                    'help': '从0-9中任意选择3个号码组成一注，所选号码与开奖号码的百位、十位、个位相同，顺序不限，即为中奖。'
                },
                '132407': {     //后三组选混合
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 3, 'check_type': 3},
                    'explain': '手动输入号码，至少输入1个三位数号码。',
                    'example': '投注方案：分別投注(0,0,1),以及(1,2,3)<br/>开奖号码后三位包括：(1)0,0,1，顺序不限，即中得后三组三；或者(2)1,2,3，顺序不限，即中得后三组六。',
                    'help': '手动输入一个3位数号码组成一注(不含豹子号)，开奖号码的百位、十位、个位符合后三组三或组六均为中奖。'
                },
                '132539': {     //后三组选和值
                    'type': 'select',
                    'param': {'titles': {zx: '和值'}, 'begin': 1, 'end': 26, 'row_num_count': 13, 'selector': 0},
                    'calculate': {'method': 'formula_value_add', 'value': 'zu_san', num_separator: '$'},
                    'explain': '从1-26中任意选择一个或一个以上号码。',
                    'example': '投注方案：和值3<br/>开奖号码后三位：(1)开出003号码，顺序不限，即中后三组三；(2)开出012号码，顺序不限，即中后三组六。',
                    'help': '所选数值等于开奖号码百位、十位、个位三个数字相加之和(不含豹子号)，即为中奖。'
                },
                '132533': {     //后三组选包胆
                    'type': 'select',
                    'param': {'titles': {zx: '包胆'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_count_fold', 'bet': '54', num_separator: '$'},
                    'explain': '从0-9中任意选择一个号码。',
                    'example': '投注方案：包胆3<br/>开奖号码后三位：(1)出现3xx或者33x,即中后三组三；(2)出现3xy，即中后三组六。',
                    'help': '从0-9中任意选择1个包胆号码，开奖号码的百位、十位、个位中任意1位与所选包胆号码相同(不含豹子号)，即为中奖。'
                },
                'hs_hz_ws': {       //后三和值尾数
                    'type': 'select',
                    'param': {
                        'titles': {hz_ws: '和值尾数'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从0-9中任意选择一个或一个以上号码。',
                    'example': '投注方案：和值尾数8<br/>开奖号码：后三位和值尾数为8，即中得和值尾数。',
                    'help': '所选数值等于开奖号码的百位、十位、个位三个数字相加之和的尾数，即为中奖。'
                },
                'hs_ts': {     //后三特殊号
                    'type': 'select',
                    'param': {'titles': {tsh: '特殊号'}, 'cs': 'tsh', 'selector': 0},
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '选择一个号码形态。',
                    'example': '投注方案：豹子<br/>开奖号码后三位：三个数字全部相同，即中得豹子。<br/>投注方案：顺子<br/>开奖号码后三位：为连续数字，例如678，即中得顺子。<br/>投注方案：对子<br/>开奖号码后三位：3个数字中有2个数字相同，即中得对子。',
                    'help': '所选的号码特殊属性和开奖号码后3位的属性一致，即为中奖。其中：1.顺子号的个、十、百位不分顺序(特别号码：019、089也是顺子号)；2.对子号指的是开奖号码的后三位当中，任意2位数字相同的三位数号码。'
                }
            },
            'wf_qe': {
                title: '前二',
                row: {
                    '前二直选': ['10', '11', '120238', '120232'],
                    '前二组选': ['120204', '120203', '120239', '120233']
                },
                '10': {     //前二直选复式
                    'type': 'select',
                    'param': {
                        'titles': {ww: '万位', qw: '千位'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从万位、千位各选一个号码组成一注。',
                    'example': '投注方案：58<br/>开奖号码前二位：58，即中前二直选。',
                    'help': '从万位、千位中选择一个2位数号码组成一注，所选号码与开奖号码的前2位相同，且顺序一致，即为中奖。'
                },
                '11': {     //前二直选单式
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 2, 'check_type': 0},
                    'explain': '手动输入号码，至少输入1个二位数号码组成一注。',
                    'example': '投注方案：58<br/>开奖号码前二位：58，即中前二直选。',
                    'help': '手动输入一个2位数号码组成一注，所选号码的万位、千位与开奖号码相同，且顺序一致，即为中奖。'
                },
                '120238': {     //前二直选和值
                    'type': 'select',
                    'param': {'titles': {zhi: '和值'}, 'begin': 0, 'end': 18, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_value_add', 'value': 'zhi_er', num_separator: '$'},
                    'explain': '从0-18中任意选择一个或一个以上号码。',
                    'example': '投注方案：和值1<br/>开奖号码前二位：01,10，即中前二直选。',
                    'help': '所选数值等于开奖号码的万位、千位二个数字相加之和，即为中奖。'
                },
                '120232': {     //前二直选跨度
                    'type': 'select',
                    'param': {'titles': {zhi: '跨度'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_value_add', 'value': 'kd_er', num_separator: ','},
                    'explain': '从0-9中选择一个或一个以上号码。',
                    'example': '投注方案：跨度9<br/>开奖号码为9,0,-,-,-或0,9,-,-,-，即中前二直选。',
                    'help': '所选数值等于开奖号码的前2位最大与最小数字相减之差，即为中奖。'
                },
                '120204': {     //前二组选复式
                    'type': 'select',
                    'param': {'titles': {zx: '组选'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_zx_fs', 'base_len': 2},
                    'explain': '从0-9中任意选择2个或2个以上号码。',
                    'example': '投注方案：5,8<br/>开奖号码前二位：85 或58(顺序不限，不含对子号)，即中前二组选。',
                    'help': '从0-9中选2个号码组成一注，所选号码与开奖号码的万位、千位相同，顺序不限（不含对子号），即中奖。'
                },
                '120203': {     //前二组选单式
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 2, 'check_type': 1},
                    'explain': '手动输入号码，至少输入1个二位数号码。',
                    'example': '投注方案：5,8<br/>开奖号码前二位：85 或58(顺序不限，不含对子号)，即中前二组选。',
                    'help': '手动输入一个2位数号码组成一注，所选号码的万位、千位与开奖号码相同，顺序不限（不含对子号），即为中奖。'
                },
                '120239': {     //前二组选和值
                    'type': 'select',
                    'param': {'titles': {zx: '和值'}, 'begin': 1, 'end': 17, 'row_num_count': 9, 'selector': 2},
                    'calculate': {'method': 'formula_value_add', 'value': 'zu_er', num_separator: '$'},
                    'explain': '从1-17中任意选择一个或一个以上号码。',
                    'example': '投注方案：和值1<br/>开奖号码前二位：10或01 (顺序不限，不含对子号)，即中前二组选。',
                    'help': '所选数值等于开奖号码的万位、千位二个数字相加之和（不含对子号），即为中奖。'
                },
                '120233': {     //前二组选包胆
                    'type': 'select',
                    'param': {'titles': {zx: '包胆'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_count_fold', 'bet': 9, num_separator: '$'},
                    'explain': '从0-9中任意选择一个号码。',
                    'example': '投注方案：包胆号码8<br/>开奖号码前二位：出现1个8（不包括2个8），即中前二组选。',
                    'help': '从0-9中任意选择1个包胆号码，开奖号码的万位、千位中任意1位包含所选的包胆号码相同（不含对子号），即为中奖。'
                }
            },
            'wf_he': {
                title: '后二',
                row: {
                    '后二直选': ['12', '13', '123538', '123532'],
                    '后二组选': ['14', '15', '123539', '123533']
                },
                '12': {     //后二直选复式
                    'type': 'select',
                    'param': {
                        'titles': {sw: '十位', ge: '个位'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从十位、个位各选一个号码组成一注。',
                    'example': '投注方案：58<br/>开奖号码后二位：58，即中后二直选。',
                    'help': '从十位、个位中选择一个2位数号码组成一注，所选号码与开奖号码的十位、个位相同，且顺序一致，即为中奖。'
                },
                '13': {     //后二直选单式
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 2, 'check_type': 0},
                    'explain': '手动输入号码，至少输入1个二位数号码组成一注。',
                    'example': '投注方案：58<br/>开奖号码后二位：58，即中后二直选。',
                    'help': '手动输入一个2位数号码组成一注，所选号码的十位、个位与开奖号码相同，且顺序一致，即为中奖。'
                },
                '123538': {     //后二直选和值
                    'type': 'select',
                    'param': {'titles': {zhi: '和值'}, 'begin': 0, 'end': 18, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_value_add', 'value': 'zhi_er', num_separator: '$'},
                    'explain': '从0-18中任意选择一个或一个以上号码。',
                    'example': '投注方案：和值1<br/>开奖号码后二位：01,10，即中后二直选。',
                    'help': '所选数值等于开奖号码的十位、个位二个数字相加之和，即为中奖。'
                },
                '123532': {     //后二直选跨度
                    'type': 'select',
                    'param': {'titles': {zhi: '跨度'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_value_add', 'value': 'kd_er', num_separator: ','},
                    'explain': '从0-9中选择一个或一个以上号码。',
                    'example': '投注方案：跨度9<br/>开奖号码为-,-,-,9,0或-,-,-,0,9，即中后二直选。',
                    'help': '所选数值等于开奖号码的后2位最大与最小数字相减之差，即为中奖。'
                },
                '14': {     //后二组选复式
                    'type': 'select',
                    'param': {'titles': {zx: '组选'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_zx_fs', 'base_len': 2},
                    'explain': '从0-9中任意选择2个或2个以上号码。',
                    'example': '投注方案：5,8<br/>开奖号码后二位：85 或58 (顺序不限，不含对子号)，即中后二组选。',
                    'help': '从0-9中选2个号码组成一注，所选号码与开奖号码的十位、个位相同，顺序不限（不含对子号），即为中奖。'
                },
                '15': {     //后二组选单式
                    'type': 'input',
                    param: {},
                    calculate: {'base_len': 2, 'check_type': 1},
                    'explain': '手动输入号码，至少输入1个二位数号码。',
                    'example': '投注方案：5,8<br/>开奖号码后二位：85 或58 (顺序不限，不含对子号)，即中后二组选。',
                    'help': '手动输入一个2位数号码组成一注，所选号码的十位、个位与开奖号码相同，顺序不限（不含对子号），即为中奖。'
                },
                '123539': {     //后二组选和值
                    'type': 'select',
                    'param': {'titles': {zx: '和值'}, 'begin': 1, 'end': 17, 'row_num_count': 9, 'selector': 2},
                    'calculate': {'method': 'formula_value_add', 'value': 'zu_er', num_separator: '$'},
                    'explain': '从1-17中任意选择一个或一个以上号码。',
                    'example': '投注方案：和值1<br/>开奖号码后二位：10或01(顺序不限，不含对子号)，即中后二组选。',
                    'help': '所选数值等于开奖号码的十位、个位二个数字相加之和（不含对子号），即为中奖。'
                },
                '123533': {     //后二组选包胆
                    'type': 'select',
                    'param': {'titles': {zx: '包胆'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_count_fold', 'bet': 9, num_separator: '$'},
                    'explain': '从0-9中任意选择一个号码。',
                    'example': '投注方案：包胆号码8<br/>开奖号码后二位：出现1个8（不包括2个8），即中后二组选。',
                    'help': '从0-9中任意选择1个包胆号码，开奖号码的十位、个位中任意1位包含所选的包胆号码相同（不含对子号），即为中奖。'
                }
            },
            'wf_dwd': {
                title: '定位胆',
                row: {
                    '定位胆': ['9']
                },
                '9': {  //五星定位胆
                    'type': 'select',
                    'param': {
                        'titles': {ww: '万位', qw: '千位', bw: '百位', sw: '十位', ge: '个位'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_num_count'},
                    'explain': '从万位、千位、百位、十位、个位任意位置上选择1个或一个以上号码。',
                    'example': '投注方案：万位 1<br>开奖号码：万位 1，即中定位胆万位。',
                    'help': '从万位、千位、百位、十位、个位任意位置上至少选择1个以上号码，所选号码与相同位置上的开奖号码一致，即为中奖。'
                }
            },
            'wf_bdw': {
                title: '不定位',
                row: {
                    '三星': ['19', '131409', '1', '130352', '131452', '132552'],
                    '四星': ['141551', '141552'],
                    '五星': ['150052', '150053']
                },
                '1': {      //后三不定位复式
                    'type': 'select',
                    'param': {'titles': {bdw: '不定位'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_num_count'},
                    'explain': '从0-9中任意选择1个以上号码。',
                    'example': '投注方案：1<br/>开奖号码后三位：至少出现1个1，即中后三一码不定位。',
                    'help': '从0-9中选择1个号码，每注由1个号码组成，只要开奖号码的百位、十位、个位中包含所选号码，即为中奖。'
                },
                '19': {     //前三不定位复式
                    'type': 'select',
                    'param': {'titles': {bdw: '不定位'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_num_count'},
                    'explain': '从0-9中任意选择1个以上号码。',
                    'example': '投注方案：1<br/>开奖号码前三位：至少出现1个1，即中前三一码不定位。',
                    'help': '从0-9中选择1个号码，每注由1个号码组成，只要开奖号码的万位、千位、百位中包含所选号码，即为中奖。'
                },
                '131409': {   //中三不定位复式
                    'type': 'select',
                    'param': {'titles': {bdw: '不定位'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_num_count'},
                    'explain': '从0-9中任意选择1个以上号码。',
                    'example': '投注方案：1<br/>开奖号码前三位：至少出现1个1，即中三一码不定位。',
                    'help': '从0-9中选择1个号码，每注由1个号码组成，只要开奖号码的千位、百位、十位中包含所选号码，即为中奖。'
                },
                '132552': {     //后三二码不定位
                    'type': 'select',
                    'param': {'titles': {bdw: '不定位'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_zx_fs', 'base_len': 2},
                    'explain': '从0-9中任意选择2个以上号码。',
                    'example': '投注方案：1,2<br/>开奖号码后三位：至少出现1和2各1个，即中后三二码不定位。',
                    'help': '从0-9中选择2个号码，每注由2个不同的号码组成，开奖号码的百位、十位、个位中同时包含所选的2个号码，即为中奖。'
                },
                '131452': {     //中三二码不定位
                    'type': 'select',
                    'param': {'titles': {bdw: '不定位'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_zx_fs', 'base_len': 2},
                    'explain': '从0-9中任意选择2个以上号码。',
                    'example': '投注方案：1,2<br/>开奖号码中间三位：至少出现1和2各1个，即中中三二码不定位。',
                    'help': '从0-9中选择2个号码，每注由2个不同的号码组成，开奖号码的千位、百位、十位中同时包含所选的2个号码，即为中奖。'
                },
                '130352': {     //前三二码不定位
                    'type': 'select',
                    'param': {'titles': {bdw: '不定位'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_zx_fs', 'base_len': 2},
                    'explain': '从0-9中任意选择2个以上号码。',
                    'example': '投注方案：1,2<br/>开奖号码前三位：至少出现1和2各1个，即中前三二码不定位。',
                    'help': '从0-9中选择2个号码，每注由2个不同的号码组成，开奖号码的万位、千位、百位中同时包含所选的2个号码，即为中奖。'
                },
                '141551': {     //后四一码不定位
                    'type': 'select',
                    'param': {'titles': {bdw: '不定位'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_num_count'},
                    'explain': '从0-9中任意选择1个以上号码。',
                    'example': '投注方案：1<br/>开奖号码后四位：至少出现1个1，即中四星一码不定位。',
                    'help': '从0-9中选择1个号码，每注由1个号码组成，只要开奖号码的千位、百位、十位、个位中包含所选号码，即为中奖。'
                },
                '141552': {     //后四二码不定位
                    'type': 'select',
                    'param': {'titles': {bdw: '不定位'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_zx_fs', 'base_len': 2},
                    'explain': '从0-9中任意选择2个以上号码。',
                    'example': '投注方案：1,2<br/>开奖号码后四位：至少出现1和2各1个，即中四星二码不定位。',
                    'help': '从0-9中选择2个号码，每注由2个不同的号码组成，开奖号码的千位、百位、十位、个位中同时包含所选的2个号码，即为中奖。'
                },
                '150052': {     //五星二码不定位
                    'type': 'select',
                    'param': {'titles': {bdw: '不定位'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_zx_fs', 'base_len': 2},
                    'explain': '从0-9中任意选择2个以上号码。',
                    'example': '投注方案：1,2<br/>开奖号码：至少出现1和2各1个，即中五星二码不定位。',
                    'help': '从0-9中选择2个号码，每注由2个不同的号码组成，开奖号码的万位、千位、百位、十位、个位中同时包含所选的2个号码，即为中奖。'
                },
                '150053': {     //五星三码不定位
                    'type': 'select',
                    'param': {'titles': {bdw: '不定位'}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_zx_fs', 'base_len': 3},
                    'explain': '从0-9中任意选择3个以上号码。',
                    'example': '投注方案：1,2,3<br/>开奖号码：至少出现1、2、3各1个，即中五星三码不定位。',
                    'help': '从0-9中选择3个号码，每注由3个不同的号码组成，开奖号码的万位、千位、百位、十位、个位中同时包含所选的3个号码，即为中奖。'
                }
            },
            'wf_dx_ds': {
                title: '大小单双',
                row: {
                    '大小单双': ['120205', '16', '130337', '132537']
                },
                '120205': {     //前二大小单双
                    'type': 'select',
                    'param': {'titles': {ww: '万位', qw: '千位'}, 'cs': 'dx_ds', 'selector': 1},
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从万位、千位中的“大、小、单、双”中至少各选一个组成一注。',
                    'example': '投注方案：小双<br/>开奖号码万位与千位：小双，即中前二大小单双。',
                    'help': '对万位、千位的“大（56789）小（01234）、单（13579）双（02468）”形态进行购买，所选号码的位置、形态与开奖号码的位置、形态相同，即为中奖。'
                },
                '16': {     //后二大小单双
                    'type': 'select',
                    'param': {'titles': {sw: '十位', ge: '个位'}, 'cs': 'dx_ds', 'selector': 1},
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从十位、个位中的“大、小、单、双”中至少各选一个组成一注。',
                    'example': '投注方案：大单<br/>开奖号码十位与个位：大单，即中后二大小单双。',
                    'help': '对十位和个位的“大（56789）小（01234）、单（13579）双（02468）”形态进行购买，所选号码的位置、形态与开奖号码的位置、形态相同，即为中奖。'
                },
                '130337': {     //前三大小单双
                    'type': 'select',
                    'param': {'titles': {ww: '万位', qw: '千位', bw: '百位'}, 'cs': 'dx_ds', 'selector': 1},
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从万位、千位、百位中的“大、小、单、双”中至少各选一个组成一注。',
                    'example': '投注方案：小双小<br/>开奖号码万、千、百位：小双小，即中前三大小单双。',
                    'help': '对万位、千位和百位的“大（56789）小（01234）、单（13579）双（02468）”形态进行购买，所选号码的位置、形态与开奖号码的位置、形态相同，即为中奖。'
                },
                '132537': {     //后三大小单双
                    'type': 'select',
                    'param': {'titles': {bw: '百位', sw: '十位', ge: '个位'}, 'cs': 'dx_ds', 'selector': 1},
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从百位、十位、个位中的“大、小、单、双”中至少各选一个组成一注。',
                    'example': '投注方案：大单大<br/>开奖号码百、十、个位：大单大，即中后三大小单双。',
                    'help': '对百位、十位和个位的“大（56789）小（01234）、单（13579）双（02468）”形态进行购买，所选号码的位置、形态与开奖号码的位置、形态相同，即为中奖。'
                }
            },
            'wf_qh': {
                title: ''
            }
        },
        'wf_class_rx': {
            'wf_rx_er': {
                title: '任选二',
                row: {
                    '任二直选': ['120002', '120001', '120038'],
                    '任二组选': ['120004', '120003', '120039']
                },
                '120002': {     //任选二直选复式
                    'type': 'select',
                    'param': {
                        'titles': {ww: '万位', qw: '千位', bw: '百位', sw: '十位', ge: '个位'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_rx_zhi_fs', 'base_len': 2},
                    'explain': '从万位、千位、百位、十位、个位中至少两位上各选一个号码组成一注。',
                    'example': '投注方案：万位1，十位2<br/>开奖号码：1**2*，即中任二直选。',
                    'help': '从万位、千位、百位、十位、个位中任意选择两个位，在这两个位上至少各选1个号码组成一注，所选2个位置上的开奖号码与所选号码完全相同，且顺序一致，即为中奖。'
                },
                '120001': {     //任选二直选单式
                    'type': 'input',
                    'param': {'num_location': 'checkbox'},
                    'calculate': {'base_len': 2, 'check_type': 0, location: 'zx'},
                    'explain': '从万位、千位、百位、十位、个位中至少选择两个位置，至少手动输入一个两位数号码组成一注。',
                    'example': '投注方案：勾选位置千位、个位，输入号码12<br/>开奖号码：*1**2，即中任二直选。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选两个位置，手动输入一个两位数号码组成一注，所选2个位置和输入的号码都与开奖号码相同，且顺序一致，即为中奖。'
                },
                '120038': {     //任选二直选和值
                    'type': 'select',
                    'param': {
                        'titles': {'zhi': '和值'},
                        'begin': 0,
                        'end': 18,
                        'row_num_count': 10,
                        'selector': 0,
                        'num_location': 'checkbox'
                    },
                    'calculate': {
                        'method': 'formula_rx_value_add',
                        'base_len': 2,
                        'value': 'zhi_er',
                        num_separator: '$',
                        location: 'zx'
                    },
                    'explain': '从万位、千位、百位、十位、个位中至少选择两个位置，至少选择一个和值号码组成一注。',
                    'example': '投注方案：勾选位置千位、个位，选择和值15<br/>开奖号码：*8**7，即中任二直选和值。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选两个位置，然后选择一个和值，所选2个位置的开奖号码相加之和与所选和值一致，且顺序一致，即为中奖。'
                },
                '120004': {     //任选二组选复式
                    'type': 'select',
                    'param': {
                        'titles': {'zx': '组选'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2,
                        'num_location': 'checkbox'
                    },
                    'calculate': {'method': 'formula_rx_zu_fs', 'base_len': 2, location: 'zx'},
                    'explain': '从万位、千位、百位、十位、个位中至少选择两个位置，号码区至少选择两个号码组成一注。',
                    'example': '投注方案：勾选位置万位、个位，选择号码79<br/>开奖号码：9***7 或 7***9，均中任二组选。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选两个位置，然后从0-9中选择两个号码组成一注，所选2个位置的开奖号码与所选号码一致，顺序不限，即为中奖。'
                },
                '120003': {     //任选二组选单式
                    'type': 'input',
                    'param': {'num_location': 'checkbox'},
                    'calculate': {'base_len': 2, 'check_type': 1, location: 'zx'},
                    'explain': '从万位、千位、百位、十位、个位中至少选择两个位置，至少手动输入一个两位数号码组成一注。',
                    'example': '投注方案：勾选位置万位、个位，输入号码79<br/>开奖号码：9***7 或 7***9，均中任二组选。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选两个位置，然后输入两个号码组成一注，所选2个位置的开奖号码与输入号码一致，顺序不限，即为中奖。'
                },
                '120039': {     //任选二组选和值
                    'type': 'select',
                    'param': {
                        'titles': {'zx': '和值'},
                        'begin': 1,
                        'end': 17,
                        'row_num_count': 10,
                        'selector': 0,
                        'num_location': 'checkbox'
                    },
                    'calculate': {
                        'method': 'formula_rx_value_add',
                        'value': 'zu_er',
                        'base_len': 2,
                        num_separator: '$',
                        location: 'zx'
                    },
                    'explain': '从万位、千位、百位、十位、个位中至少选择两个位置，至少选择一个和值号码组成一注。',
                    'example': '投注方案：勾选位置千位、个位，选择和值6<br/>开奖号码：*4**2 或 *2**4，均中任二组选和值',
                    'help': '从万位、千位、百位、十位、个位中任意勾选两个位置，然后选择一个和值，所选2个位置的开奖号码相加之和与所选和值一致，顺序不限，即为中奖。'
                }
            },
            'wf_rx_san': {
                title: '任选三',
                row: {
                    '任三直选': ['130002', '130001', '130038'],
                    '任三组选': ['130042', '130041', '130044', '130043', '130030', '130039']
                },
                '130002': {     //任选三直选复式
                    'type': 'select',
                    'param': {
                        'titles': {ww: '万位', qw: '千位', bw: '百位', sw: '十位', ge: '个位'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_rx_zhi_fs', 'base_len': 3},
                    'explain': '从万位、千位、百位、十位、个位中至少三位上各选一个号码组成一注。',
                    'example': '投注方案：万位1、千位5、十位2<br/>开奖号码：15*2*，即中任三直选。',
                    'help': '从万位、千位、百位、十位、个位中任意选择三个位，在这三个位上至少各选1个号码组成一注，所选3个位置上的开奖号码与所选号码完全相同，且顺序一致，即为中奖。'
                },
                '130001': {     //任选三直选单式
                    'type': 'input',
                    'param': {'num_location': 'checkbox'},
                    'calculate': {'base_len': 3, 'check_type': 0, location: 'zx'},
                    'explain': '从万位、千位、百位、十位、个位中至少选择三个位置，至少手动输入一个三位数号码组成一注。',
                    'example': '投注方案：勾选位置万位、千位、个位，输入号码152<br/>开奖号码：15**2，即中任三直选。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选三个位置，手动输入一个三位数号码组成一注，所选三个位置上的开奖号码与输入号码完全相同，且顺序一致，即为中奖。'
                },
                '130038': {     //任选三直选和值
                    'type': 'select',
                    'param': {
                        'titles': {'zx_hz': '和值'},
                        'begin': 0,
                        'end': 27,
                        'row_num_count': 14,
                        'selector': 0,
                        'num_location': 'checkbox'
                    },
                    'calculate': {
                        'method': 'formula_rx_value_add',
                        'value': 'zhi_san',
                        'base_len': 3,
                        num_separator: '$',
                        location: 'zx'
                    },
                    'explain': '从万位、千位、百位、十位、个位中至少选择三个位置，至少选择一个和值号码组成一注。',
                    'example': '投注方案：勾选位置万位、千位、个位，选择和值8<br/>开奖号码：22**4，即中任三直选和值。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选三个位置，然后选择一个和值，所选3个位置的开奖号码相加之和与所选和值一致，且顺序一致，即为中奖。'
                },
                '130042': {     //任选三组三复式
                    'type': 'select',
                    'param': {
                        'titles': {'zs_fs': '组三'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2,
                        'num_location': 'checkbox'
                    },
                    'calculate': {'method': 'formula_rx_zs_fs', 'num_len': 2, 'base_len': 3, location: 'zx'},
                    'explain': '从万位、千位、百位、十位、个位中至少选择三个位置，号码区至少选择两个号码组成一注。',
                    'example': '投注方案：勾选位置万位、千位、个位，选择号码18<br/>开奖号码：11**8 或 18**1，均中任三组三。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选三个位置，然后从0-9中选择两个号码组成一注，所选3个位置的开奖号码与所选号码一致，顺序不限，即为中奖。'
                },
                '130041': {     //任选三组三单式
                    'type': 'input',
                    'param': {'num_location': 'checkbox'},
                    'calculate': {'base_len': 3, 'check_type': 2, location: 'zx'},
                    'explain': '从万位、千位、百位、十位、个位中至少选择三个位置，至少手动输入两个号码组成一注。',
                    'example': '投注方案：勾选位置万位、千位、个位，输入号码779<br/>开奖号码：97**7 或 79**7，均中任三组三。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选三个位置，然后输入两个号相同号码和一个不同号码组成一注，所选3个位置的开奖号码与输入号码一致，顺序不限，即为中奖。'
                },
                '130044': {     //任选三组六复式
                    'type': 'select',
                    'param': {
                        'titles': {'zl_fs': '组六'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2,
                        'num_location': 'checkbox'
                    },
                    'calculate': {'method': 'formula_rx_zu_fs', 'base_len': 3, location: 'zx'},
                    'explain': '从万位、千位、百位、十位、个位中至少选择三个位置，号码区至少选择三个号码组成一注。',
                    'example': '投注方案：勾选位置万位、百位、个位，选择号码159<br/>开奖号码：1*5*9 或 9*1*5，均中任三组六。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选三个位置，然后从0-9中选择三个号码组成一注，所选3个位置的开奖号码与所选号码一致，顺序不限，即为中奖。'
                },
                '130043': {     //任选三组六单式
                    'type': 'input',
                    'param': {'num_location': 'checkbox'},
                    'calculate': {'base_len': 3, 'check_type': 1, location: 'zx'},
                    'explain': '从万位、千位、百位、十位、个位中至少选择三个位置，至少手动输三个号码组成一注。',
                    'example': '投注方案：勾选位置万位、百位、个位，选择号码159<br/>开奖号码：1*5*9 或 9*1*5，即中任三组六。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选三个位置，然后输入三个各不相同的3个号码组成一注，所选3个位置的开奖号码与输入号码一致，顺序不限，即为中奖。'
                },
                '130030': {     //任选三组选混合
                    'type': 'input',
                    'param': {'num_location': 'checkbox'},
                    'calculate': {'base_len': 3, 'check_type': 3, location: 'zx'},
                    'explain': '从万位、千位、百位、十位、个位中至少选择三个位置，手动至少输入三个号码组成一注（不包含豹子号）。',
                    'example': '投注方案：勾选位置千位、百位、个位，分別投注(0,0,1),以及(1,2,3)<br/>开奖号码：*00*1，顺序不限，即中任三组三；或者(2)*21*3，顺序不限，即中任三组六。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选三个位置，然后输入三个号码组成一注，所选3个位置的开奖号码与输入号码一致，顺序不限，即为中奖。'
                },
                '130039': {     //任选三组选和值
                    'type': 'select',
                    'param': {
                        'titles': {'zx_hz': '和值'},
                        'begin': 1,
                        'end': 26,
                        'row_num_count': 13,
                        'selector': 0,
                        'num_location': 'checkbox'
                    },
                    'calculate': {
                        'method': 'formula_rx_value_add',
                        'value': 'zu_san',
                        'base_len': 3,
                        num_separator: '$',
                        location: 'zx'
                    },
                    'explain': '从万位、千位、百位、十位、个位中至少选择三个位置，至少选择一个和值号码组成一注。',
                    'example': '投注方案：勾选位置万位、千位、个位；选择和值8<br/>开奖号码：13**4 顺序不限，即中任三直选。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选三个位置，然后选择一个和值，所选3个位置的开奖号码相加之和与所选和值一致，顺序不限，即为中奖。'
                }
            },
            'wf_rx_si': {
                title: '任选四',
                row: {
                    '任四直选': ['140002', '140001'],
                    '任四组选': ['140041', '140042', '140043', '140044']
                },
                '140002': {     //任选四直选复式
                    'type': 'select',
                    'param': {
                        'titles': {ww: '万位', qw: '千位', bw: '百位', sw: '十位', ge: '个位'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_rx_zhi_fs', 'base_len': 4},
                    'explain': '从万位、千位、百位、十位、个位中至少四位上各选一个号码组成一注。',
                    'example': '投注方案：万位1、千位5、百位0、十位2<br/>开奖号码：1502*，即中任四直选。',
                    'help': '从万位、千位、百位、十位、个位中任意选择四个位置，在这四个位上至少各选1个号码组成一注，所选4个位置上的开奖号码与所选号码完全相同，且顺序一致，即为中奖。'
                },
                '140001': {     //任选四直选单式
                    'type': 'input',
                    'param': {'num_location': 'checkbox'},
                    'calculate': {'base_len': 4, 'check_type': 0, location: 'zx'},
                    'explain': '从万位、千位、百位、十位、个位中至少选择四个位置，至少手动输入一个四位数号码组成一注。',
                    'example': '投注方案：勾选位置万位、千位、十位、个位，输入号码1524<br/>开奖号码：15*24，即中任四直选。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选四个位置，手动输入一个四位数号码组成一注，所选4个位置上的开奖号码与输入号码完全相同，且顺序一致，即为中奖。'
                },
                '140041': {     //任选四组选24
                    'type': 'select',
                    'param': {
                        'titles': {'zx': '组选24'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2,
                        'num_location': 'checkbox'
                    },
                    'calculate': {'method': 'formula_rx_zu_fs', 'base_len': 4, location: 'zx'},
                    'explain': '从万位、千位、百位、十位、个位中至少选择四个位置，号码区至少选择四个号码组成一注。',
                    'example': '投注方案：勾选位置万位、千位、十位、个位，选择号码1234<br/>开奖号码：12*34 或 13*24，均中任四组选24。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选四个位置，然后从0-9中选择四个号码组成一注，所选4个位置的开奖号码与所选号码一致，顺序不限，即为中奖。'
                },
                '140042': {     //任选四组选12
                    'type': 'select',
                    'param': {
                        'titles': {'er': '二重号', 'dan': '单号'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2,
                        'num_location': 'checkbox'
                    },
                    'calculate': {
                        'method': 'formula_rx_zx',
                        'oneRow': 0,
                        'moreRow': 1,
                        'num_len': 2,
                        'base_len': 4,
                        location: 'zx'
                    },
                    'explain': '从万位、千位、百位、十位、个位中至少选择四个位置，从“二重号”选择一个号码，“单号”中选择两个号码组成一注。',
                    'example': '投注方案：勾选位置万位、千位、十位、个位，选择二重号：8，单号：0、6<br/>开奖号码：88*06 或 08*68，均中任四组选12。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选四个位置，然后选择1个二重号码和2个单号号码组成一注，所选4个位置的开奖号码中包含与所选号码，且所选二重号码在所选4个位置的开奖号码中出现了2次，即为中奖。'
                },
                '140043': {     //任选四组选6
                    'type': 'select',
                    'param': {
                        'titles': {'er': '二重号'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2,
                        'num_location': 'checkbox'
                    },
                    'calculate': {'method': 'formula_rx_zl', 'num_len': 2, 'base_len': 4, location: 'zx'},
                    'explain': '从万位、千位、百位、十位、个位中至少选择四个位置，从“二重号”中选择两个号码组成一注。',
                    'example': '投注方案：勾选位置万位、千位、十位、个位，选择二重号：6、8<br/>开奖号码：66*88 或 68*68，均中任四组选6。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选四个位置，然后从0-9中选择2个二重号组成一注，所选4个位置的开奖号码与所选号码一致，并且所选的2个二重号码在所选4个位置的开奖号码中分别出现了2次，顺序不限，即为中奖。'
                },
                '140044': {     //任选四组选4s
                    'type': 'select',
                    'param': {
                        'titles': {'san': '三重号', 'dan': '单号'},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2,
                        'num_location': 'checkbox'
                    },
                    'calculate': {
                        'method': 'formula_rx_zx',
                        'oneRow': 0,
                        'moreRow': 1,
                        'num_len': 1,
                        'base_len': 4,
                        location: 'zx'
                    },
                    'explain': '从万位、千位、百位、十位、个位中至少选择四个位置，从“三重号”选择一个号码，“单号”中选择一个号码组成一注。',
                    'example': '投注方案：勾选位置万位、千位、十位、个位，选择三重号：8，单号：0<br/>开奖号码：88*80 或 80*88，均中任四组选4。',
                    'help': '从万位、千位、百位、十位、个位中任意勾选四个位置，然后从0-9中选择1个三重号和1个单号组成一注，所选4个位置的开奖号码与所选号码一致，并且所选三重号码在所选4个位置的开奖号码中出现了3次，顺序不限，即为中奖。'
                }
            },
            'wf_qh': {
                title: ''
            }
        }
    },
    //彩种类型2     福彩3D
    LOTTERY_2: {
        num_min: 0,
        num_max: 9,
        num_len: 1,
        run_num_length: 3,
        wf_class: {
            wf_sx: {
                title: '三星',
                row: {
                    '三星直选': ['24', '25', '37'],
                    '三星组选': ['26', '27', '28', '29', '230007', '230008'],
                    '三星趣味': ['230031', '230032', '230033', '230034']
                },
                '24': {//三星直选复式
                    'type': 'select',
                    'param': {
                        'titles': {bai: "百位", shi: "十位", ge: "个位"},
                        'begin': 0,
                        'end': 9,
                        row_num_count: 10,
                        'selector': 2
                    },
                    'calculate': {method: 'formula_num_multiply'},
                    'explain': '从百位、十位、个位各选一个号码组成一注。',
                    'example': '投注方案：345<br>开奖号码：345，即中后三直选。',
                    'help': '从百味、十位、个位中选择一个3位数号码组成一注，所选号码与开奖号码后3位相同，且顺序一致，即为中奖。'
                },
                '25': {//三星直选单式
                    'type': 'input',
                    'param': {},
                    'calculate': {base_len: 3, check_type: 0},
                    'explain': '手动输入号码，至少输入1个三位数号码组成一注。',
                    'example': '投注方案：345<br>开奖号码：345，即中后三直选。',
                    'help': '手动输入一个3位数号码组成一注，所选号码与开奖号码的百味、十位、个位相同，且顺序一致，即为中奖。'
                },
                '37': {//三星直选和值
                    'type': 'select',
                    'param': {'titles': {hz: "直选和值"}, 'begin': 0, 'end': 27, row_num_count: 14, 'selector': 0},
                    'calculate': {'method': 'formula_value_add', 'value': 'zhi_san', num_separator: '$'},
                    'explain': '从0-27中任意选择1个或1个以上号码。',
                    'example': '投注方案：和值1<br>开奖号码：后三位001,010,100，即中后三直选。',
                    'help': '所选数值等于开奖号码的百位、十位、个位三个数字相加之和，即为中奖。'
                },
                '26': {//三星组三复式
                    'type': 'select',
                    'param': {'titles': {zs_fs: "组三"}, 'begin': 0, 'end': 9, row_num_count: 10, 'selector': 2},
                    'calculate': {method: 'formula_num_fold', 'base_len': 2},
                    'explain': '从0-9中任意选择2个或2个以上号码。',
                    'example': '投注方案：588<br>开奖号码：后三位588（顺序不限），即中后三组选三。',
                    'help': '从0-9中选择2个数字组成两注，所选号码与开奖号码的百味、十位、个位相同，且顺序不限，即为中奖。'
                },
                '27': {//三星组三单式
                    'type': 'input',
                    'param': {},
                    'calculate': {base_len: 3, check_type: 2},
                    'explain': '手动输入号码，至少输入1个三位数号码（三个数字必须有两个数字相同）。',
                    'example': '投注方案：001<br>开奖号码：后三位010（顺序不限），即中后三组选三。',
                    'help': '手动输入一个3位数号码组成一注，三个数字中必须有两个数字相同，输入号码与开奖号码的百位、十位、个位相同，顺序不限，即为中奖。'
                },
                '28': {//三星组六复式
                    'type': 'select',
                    'param': {'titles': {zu: "组六"}, 'begin': 0, 'end': 9, row_num_count: 10, 'selector': 2},
                    'calculate': {'method': 'formula_zx_fs', base_len: 3},
                    'explain': '从0-9中任意选择3个或3个以上号码。',
                    'example': '投注方案：258<br>开奖号码：后三位852（顺序不限），即中后三组选六。',
                    'help': '从0-9中任意选择3个号码组成一注，所选号码与开奖号码的百味、十位、个位相同，顺序不限，即为中奖。'
                },
                '29': {//三星组六单式
                    'type': 'input',
                    'param': {},
                    'calculate': {base_len: 3, check_type: 1},
                    'explain': '手动输入号码，至少输入1个三位数号码（三个数字完全不相同）。',
                    'example': '投注方案：123<br>开奖号码：后三位321（顺序不限），即中后三组选六。',
                    'help': '手动输入一个3位数号码组成一注，输入号码与开奖号码的百位、十位、个位相同，顺序不限，即为中奖。'
                },
                '230007': {//三星组选混合
                    'type': 'input',
                    'param': {},
                    'calculate': {base_len: 3, check_type: 3},
                    'explain': '手动输入号码，至少输入1个三位数号码。',
                    'example': '投注方案：001和123<br>开奖号码：后三位001（顺序不限）即中后三组选三，或者后三位312（顺序不限）即中后三组选六。',
                    'help': '手动输入一个3位数号码组成一注（不含豹子号），开奖号码的百位、十位、个位符合后三组三或者组六均为中奖。'
                },
                '230008': {//三星组选和值
                    'type': 'select',
                    'param': {'titles': {zx: "和值"}, 'begin': 1, 'end': 26, row_num_count: 13, 'selector': 0},
                    'calculate': {'method': 'formula_value_add', 'value': 'zu_san', num_separator: '$'},
                    'explain': '从1-26中任意选择1个或1个以上号码。',
                    'example': '投注方案：和值3<br>开奖号码：后三位003（顺序不限）即中后三组选三，或者后三位012（顺序不限）即中后三组选六。',
                    'help': '所选数值等于开奖号码的百位、十位、个位三个数字相加之和（非豹子号），即为中奖。'
                },
                '230031': {//三星趣味012
                    'type': 'select',
                    'param': {'titles': {zero: "0", one: "1", two: "2"}, 'cs': 'fc_spice_012', 'selector': 1},
                    'calculate': {
                        'method': 'formula_value_add',
                        'value': 'fc_spice_012',
                        num_separator: '$',
                        group: 'all_num'
                    },
                    'explain': '所选号码与开奖号码相同（且顺序一致）即中奖。',
                    'example': '所选号码与开奖号码相同（且顺序一致）即中奖。',
                    'help': '所选号码与开奖号码相同（且顺序一致）即中奖。'
                },
                '230032': {//三星趣味大小
                    'type': 'select',
                    'param': {'titles': {small: "小", big: "大"}, 'cs': 'fc_spice_dx', 'selector': 1},
                    'calculate': {
                        'method': 'formula_count_fold',
                        'bet': 125,
                        num_separator: '$',
                        group: 'all_num'
                    },
                    'explain': '所选号码与开奖号码相同（且顺序一致）即中奖。',
                    'example': '所选号码与开奖号码相同（且顺序一致）即中奖。',
                    'help': '所选号码与开奖号码相同（且顺序一致）即中奖。'
                },
                '230033': {//三星趣味质合
                    'type': 'select',
                    'param': {'titles': {zhi: "质", he: "合"}, 'cs': 'fc_spice_zh', 'selector': 1},
                    'calculate': {
                        'method': 'formula_count_fold',
                        'bet': 125,
                        num_separator: '$',
                        group: 'all_num'
                    },
                    'explain': '所选号码与开奖号码相同（且顺序一致）即中奖。',
                    'example': '所选号码与开奖号码相同（且顺序一致）即中奖。',
                    'help': '所选号码与开奖号码相同（且顺序一致）即中奖。'
                },
                '230034': {//三星趣味奇偶
                    'type': 'select',
                    'param': {'titles': {ji: "奇", ou: "偶"}, 'cs': 'fc_spice_jo', 'selector': 1},
                    'calculate': {
                        'method': 'formula_count_fold',
                        'bet': 125,
                        num_separator: '$',
                        group: 'all_num'
                    },
                    'explain': '所选号码与开奖号码相同（且顺序一致）即中奖。',
                    'example': '所选号码与开奖号码相同（且顺序一致）即中奖。',
                    'help': '所选号码与开奖号码相同（且顺序一致）即中奖。'
                }
            },
            wf_ex: {
                title: '二星',
                row: {
                    '二星直选': ['31', '32', '35', '36'],
                    '二星组选': ['220203', '220204', '221303', '221304']
                },
                '31': {//前二直选复式
                    'type': 'select',
                    'param': {
                        'titles': {bai: "百位", shi: "十位"},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从百位、十位中至少各选1个号码组成一注。',
                    'example': '投注方案：58<br>开奖号码：前二位58，即中前二直选。',
                    'help': '从百味、十位中选择一个2位数号码组成一注，所选号码与开奖号码的前2位相同，且顺序一致，即为中奖。'
                },
                '32': {//前二直选单式
                    'type': 'input',
                    'param': {},
                    'calculate': {'base_len': 2, 'check_type': 0},
                    'explain': '手动输入号码，至少输入1个二位数号码组成一注。',
                    'example': '投注方案：58<br>开奖号码：前二位58，即中前二直选。',
                    'help': '手动输入一个2位数号码组成一注，输入号码的百味、十位与开奖号码相同，且顺序一致，即为中奖。'
                },
                '35': {//后二直选复式
                    'type': 'select',
                    'param': {
                        'titles': {shi: "十位", ge: "个位"},
                        'begin': 0,
                        'end': 9,
                        'row_num_count': 10,
                        'selector': 2
                    },
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从十位、个位中至少各选1个号码组成一注。',
                    'example': '投注方案：58<br>开奖号码：后二位58，即中后二直选。',
                    'help': '从十位、个位中选择一个2位数号码组成一注，所选号码与开奖号码的后2位相同，且顺序一致，即为中奖。'
                },
                '36': {//后二直选单式
                    'type': 'input',
                    'param': {},
                    'calculate': {'base_len': 2, 'check_type': 0},
                    'explain': '手动输入号码，至少输入1个二位数号码组成一注。',
                    'example': '投注方案：58<br>开奖号码：后二位58，即中后二直选。',
                    'help': '手动输入一个2位数号码组成一注，输入号码的十位、个位与开奖号码相同，且顺序一致，即为中奖。'
                },
                '220203': {//前二组选复式
                    'type': 'select',
                    'param': {'titles': {zx: "组选"}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_zx_fs', 'base_len': 2},
                    'explain': '从0-9中任意选择2个或2个以上号码。',
                    'example': '投注方案：58<br>开奖号码：前二位85或者58（顺序不限，不含对子号），即中前二组选。',
                    'help': '从0-9中选择2个数字组成一注，所选号码与开奖号码的百味、十位相同，顺序不限，即为中奖。'
                },
                '220204': {//前二组选单式
                    'type': 'input',
                    'param': {},
                    'calculate': {'base_len': 2, 'check_type': 1},
                    'explain': '手动输入号码，至少输入1个二位数号码组成一注。',
                    'example': '投注方案：58<br>开奖号码：前二位85或者58（顺序不限，不含对子号），即中前二组选。',
                    'help': '手动输入一个两位数号码组成一注，输入号码的百位、十位与开奖号码相同，顺序不限，即为中奖。'
                },
                '221303': {//后二组选复式
                    'type': 'select',
                    'param': {'titles': {zx: "组选"}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_zx_fs', 'base_len': 2},
                    'explain': '从0-9中任意选择2个或2个以上号码。',
                    'example': '投注方案：58<br>开奖号码：后二位85或者58（顺序不限，不含对子号），即中后二组选。',
                    'help': '从0-9中选择2个数字组成一注，所选号码与开奖号码的十味、个位相同（不含对子号），顺序不限，即为中奖。'
                },
                '221304': {//后二组选单式
                    'type': 'input',
                    'param': {},
                    'calculate': {'base_len': 2, 'check_type': 1},
                    'explain': '手动输入号码，至少输入1个二位数号码组成一注。',
                    'example': '投注方案：58<br>开奖号码：后二位85或者58（顺序不限，不含对子号），即中后二组选。',
                    'help': '手动输入一个两位数号码组成一注，输入号码的十位、个位与开奖号码相同（不含对子号），顺序不限，即为中奖。'
                }
            },
            wf_bdw: {
                title: '不定位',
                row: {
                    '不定位': ['33']
                },
                '33': {//不定位复式
                    'type': 'select',
                    'param': {'titles': {bdw: "不定位"}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_num_count'},
                    'explain': '从01-11中共11个号码中选择1个号码，每注由1个号码组成',
                    'example': '只要当期顺序摇出的第一位、第二位、第三位开奖号码中包含所选号码，即为中奖。',
                    'help': '从01-11中共11个号码中选择1个号码，每注由1个号码组成，只要当期顺序摇出的第一位、第二位、第三位开奖号码中包含所选号码，即为中奖。'
                }
            },
            wf_dx_ds: {
                title: '大小单双',
                row: {
                    '大小单双': ['220205', '221305']
                },
                '220205': {//前二大小单双
                    'type': 'select',
                    'param': {'titles': {bai: "百位", shi: "十位"}, 'cs': 'dx_ds', 'selector': 1},
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从百位、十位中的“大、小、单、双”中至少各选一个组成。',
                    'example': '投注方案：小双<br>开奖号码：百位与十位“小双”，即中前二大小单双。',
                    'help': '对百位、十位的“大（56789）小（01234）、单（13579）双（02468）”形态进行购买，所选号码的位置、形态与开奖号码的位置、形态相同，即为中奖。'
                },
                '221305': {//后二大小单双
                    'type': 'select',
                    'param': {'titles': {shi: "十位", ge: "个位"}, 'cs': 'dx_ds', 'selector': 1},
                    'calculate': {'method': 'formula_num_multiply'},
                    'explain': '从十位、个位中的“大、小、单、双”中至少各选一个组成。',
                    'example': '投注方案：大单<br>开奖号码：十位与个位“大单”，即中后二大小单双。',
                    'help': '对十位和个位的“大（56789）小（01234）、单（13579）双（02468）”形态进行购买，所选号码的位置、形态与开奖号码的位置、形态相同，即为中奖。'
                }
            },
            wf_qy: {
                title: '前一直选',
                row: {
                    '前一直选': ['30']
                },
                '30': {//前一直选复式
                    'type': 'select',
                    'param': {'titles': {bai: "百位"}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_num_count'},
                    'explain': '前一直选',
                    'example': '前一直选',
                    'help': '前一直选'
                }
            },
            wf_hy: {
                title: '后一直选',
                row: {
                    '后一直选': ['34']
                },
                '34': {//后一直选
                    'type': 'select',
                    'param': {'titles': {ge: "个位"}, 'begin': 0, 'end': 9, 'row_num_count': 10, 'selector': 2},
                    'calculate': {'method': 'formula_num_count'},
                    'explain': '后一直选',
                    'example': '后一直选',
                    'help': '后一直选'
                }
            }
        }
    },
    //彩种类型3     十一选五
    LOTTERY_3: {
        num_min: 1,
        num_max: 11,
        num_len: 2,
        run_num_length: 5,
        wf_class: {
            wf_sm: {
                title: '三码',
                row: {
                    '三码': ['44', '45', '46', '330301', '47']
                },
                '44': {     //前三直选复式
                    'type': 'select',
                    'param': {
                        'titles': {yi: "第一位", er: '第二位', san: '第三位'},
                        begin: 1,
                        end: 11,
                        row_num_count: 11,
                        'selector': 2
                    },
                    'calculate': {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    'explain': '从第一位、第二位、第三位中至少各选择1个号码。',
                    'example': '如：选择01，02，03，开奖号码顺序为01，02，03 * *，即为中奖。',
                    'help': '从01-11共11个号码中选择3个不重复的号码组成一注，所选号码与当期顺序摇出的5个号码中的前3个号码相同，且顺序一致，即为中奖。'
                },
                '45': {     //前三直选单式
                    'type': 'input',
                    'param': {},
                    'calculate': {base_len: 3, check_type: 1, num_separator: ' '},
                    'explain': '手动输入号码，至少输入1个三位数号码组成一注。',
                    'example': '如：手动输入01 02 03，开奖号码为是01 02 03 * *，即为中奖。',
                    'help': '手动输入3个号码组成一注，所输入的号码与当期顺序摇出的5个号码中的前3个号码相同，且顺序一致，即为中奖。'
                },
                '46': {     //前三组选复式
                    'type': 'select',
                    'param': {'titles': {zu: "组选"}, begin: 1, end: 11, row_num_count: 11, 'selector': 2},
                    'calculate': {method: 'formula_zx_fs', base_len: 3, num_separator: ',', row_separator: '-'},
                    'explain': '从01-11中任意选择3个或3个以上号码。',
                    'example': '如：选择01 02 03（展开为01 02 03 * *，01 03 02 * *，02 01 03 * *，02 03 01 * *，03 01 02 * *，03 02 01 * *），开奖号码为03 01 02  如：，即为中奖。',
                    'help': '从01-11中共11个号码中选择3个号码，所选号码与当期顺序摇出的5个号码中的前3个号码相同，顺序不限，即为中奖。'
                },
                '330301': {     //前三组选单式
                    'type': 'input',
                    'param': {},
                    'calculate': {base_len: 3, check_type: 1, num_separator: ' '},
                    'explain': '手动输入号码，至少输入1个三位数号码组成一注。',
                    'example': '如：手动输入01 02 03（展开为01 02 03 * *，01 03 02 * * , 02 01 03 * *，02 03 01 * *，03 01 02 * *，03 02 01 * *），开奖号码为01 03 02 * *，即为中奖。',
                    'help': '手动输入3个号码组成一注，所输入的号码与当期顺序摇出的5个号码中的前3个号码相同，顺序不限，即为中奖。'
                },
                '47': {     //前三组选胆拖
                    'type': 'select',
                    'param': {
                        'titles': {dan: "胆码", tuo: "拖码"},
                        begin: 1,
                        end: 11,
                        row_num_count: 11,
                        selector: 2,
                        selector_index: {1: 1}
                    },
                    'calculate': {
                        method: 'formula_dt',
                        base_len: 2,
                        num_separator: ',',
                        row_separator: '-',
                        limit_row: 0,
                        limit_rule: 'no_repeat'
                    },
                    'explain': '从01-11中，选取3个及以上的号码进行投注，每注需至少包括1个胆码及2个拖码。',
                    'example': '如：选择胆码 01，选择拖码 02 06，开奖号码为 02 01 06 * *，即为中奖。',
                    'help': '分别从胆码和拖码的01-11中，至少选择1个胆码和2个拖码组成一注。当期顺序摇出的5个号码中的前3个号码中同时包含所选的1个胆码和2个拖码，顺序不限，即为中奖。'
                }
            },
            wf_em: {
                title: '二码',
                row: {
                    '二码': ['39', '320202', '40', '320201', '41']
                },
                '39': {     //前二直选复式
                    'type': 'select',
                    'param': {
                        'titles': {yi: "第一位", er: '第二位'},
                        begin: 1,
                        end: 11,
                        row_num_count: 11,
                        selector: 2
                    },
                    'calculate': {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    'explain': '从第一位、第二位中至少各选择1个号码。',
                    'example': ' 如：选择01 02，开奖号码 01 02 * * *，即为中奖。',
                    'help': '从01-11共11个号码中选择2个不重复的号码组成一注，所选号码与当期顺序摇出的5个号码中的前2个号码相同，且顺序一致，即中奖。'
                },
                '320202': {     //前二直选单式
                    'type': 'input',
                    'param': {},
                    'calculate': {base_len: 2, check_type: 1, num_separator: ' '},
                    'explain': '手动输入号码，至少输入1个两位数号码组成一注。',
                    'example': '如：手动输入01 02，开奖号码为是01 02 * * *，即为中奖。',
                    'help': '手动输入2个号码组成一注，所输入的号码与当期顺序摇出的5个号码中的前2个号码相同，且顺序一致，即为中奖。'
                },
                '40': {     //前二组选复式
                    'type': 'select',
                    'param': {'titles': {zu: "组选"}, begin: 1, end: 11, row_num_count: 11, selector: 2},
                    'calculate': {method: 'formula_zx_fs', base_len: 2, num_separator: ',', row_separator: '-'},
                    'explain': '从01-11中任意选择3个或3个以上号码。',
                    'example': '如：选择01 02 03（展开为01 02 03 * *，01 03 02 * *，02 01 03 * *，02 03 01 * *，03 01 02 * *，03 02 01 * *），开奖号码为03 01 02  如：，即为中奖。',
                    'help': '从01-11中共11个号码中选择3个号码，所选号码与当期顺序摇出的5个号码中的前3个号码相同，顺序不限，即为中奖。'
                },
                '320201': {     //前二组选单式
                    'type': 'input',
                    'param': {},
                    'calculate': {base_len: 2, check_type: 1, num_separator: ' '},
                    'explain': '手动输入号码，至少输入1个两位数号码组成一注。',
                    'example': '如：手动输入01 02（展开为01 02 * * *, 02 01 * * *），开奖号码为01 02 * * *或02 01 * * *，即为中奖。',
                    'help': '手动输入2个号码组成一注，所输入的号码与当期顺序摇出的5个号码中的前2个号码相同，顺序不限，即为中奖。'
                },
                '41': {     //前二组选胆拖
                    type: 'select',
                    param: {
                        'titles': {dan: "胆码", tuo: "拖码"},
                        begin: 1,
                        end: 11,
                        row_num_count: 11,
                        selector: 2,
                        selector_index: {1: 1}
                    },
                    calculate: {
                        method: 'formula_dt',
                        base_len: 1,
                        num_separator: ',',
                        row_separator: '-',
                        limit_row: 0,
                        limit_rule: 'no_repeat'
                    },
                    explain: '从01-11中，选取3个及以上的号码进行投注，每注需至少包括1个胆码及2个拖码。',
                    example: '如：选择胆码 01，选择拖码 02 06，开奖号码为 02 01 06 * *，即为中奖。',
                    help: '分别从胆码和拖码的01-11中，至少选择1个胆码和2个拖码组成一注。当期顺序摇出的5个号码中的前3个号码中同时包含所选的1个胆码和2个拖码，顺序不限，即为中奖。'
                }
            },
            wf_ym: {
                title: '一码',
                row: {
                    '一码': ['38']
                },
                '38': {
                    type: 'select',
                    param: {'titles': {yi: "第一位"}, begin: 1, end: 11, row_num_count: 11, selector: 2},
                    calculate: {method: 'formula_num_count', num_separator: ',', row_separator: '-'},
                    explain: '从01-11中任意选择1个或1个以上号码。',
                    example: '如：选择01，开奖号码为01 * * * *,即为中奖。',
                    help: '从01-11中共11个号码中选择1个号码，每注由1个号码组成，只要当期顺序摇出的第一位开奖号码包含所选号码，即为中奖。'
                }
            },
            wf_bdw: {
                title: '不定位',
                row: {
                    '不定位': ['330303']
                },
                '330303': {
                    type: 'select',
                    param: {'titles': {san: "前三位"}, begin: 1, end: 11, row_num_count: 11, selector: 2},
                    calculate: {method: 'formula_num_count', num_separator: ',', row_separator: '-'},
                    explain: '从01-11中任意选择1个或1个以上号码。',
                    example: '如：选择01，开奖号码为01 * * * *，* 01 * * *，* * 01 * *,即为中奖。',
                    help: '从01-11中共11个号码中选择1个号码，每注由1个号码组成，只要当期顺序摇出的第一位、第二位、第三位开奖号码中包含所选号码，即为中奖。'
                }
            },
            wf_dwd: {
                title: '定位胆',
                row: {
                    '定位胆': ['330304']
                },
                '330304': {     //定位胆
                    type: 'select',
                    param: {
                        'titles': {yi: "第一位", er: '第二位', san: '第三位'},
                        begin: 1,
                        end: 11,
                        row_num_count: 11,
                        selector: 2
                    },
                    calculate: {method: 'formula_num_count', num_separator: ',', row_separator: '-'},
                    explain: '从第一位，第二位，第三位任意位置上任意选择1个或1个以上号码。',
                    example: '如：万位上选择01，开奖号码为01 * * * *，即为中奖。<br/>如：千位上选择01，开奖号码为 * 01* * *，即为中奖。<br/>如：百位上选择01，开奖号码为 * * 01 * *，即为中奖。',
                    help: '从第一位，第二位，第三位任意1个位置或多个位置上选择1个号码，所选号码与相同位置上的开奖号码一致，即为中奖。'
                }
            },
            wf_qwx: {
                title: '趣味型',
                row: {
                    '趣味型': ['350008', '350009']
                },
                '350008': {     //定单双
                    type: 'select',
                    param: {'titles': {ding: "定单双"}, cs: 'eleven_five_dds', selector: 0},
                    calculate: {'method': 'formula_num_count', num_separator: ','},
                    explain: '从不同的单双组合中任意选择1个或1个以上的组合。',
                    example: '如：选择5单0双，开奖号码01，03，05，07，09五个单数，即为中奖。',
                    help: '从5种单双个数组合中选择1种组合，当期开奖号码的单双个数与所选单双组合一致，即为中奖。'
                },
                '350009': {     //猜中数
                    type: 'select',
                    param: {
                        'titles': {yi: "猜中位"},
                        begin: 3,
                        end: 9,
                        row_num_count: 7,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: '$'},
                    explain: '从3-9中任意选择1个或1个以上数字。',
                    example: '如：选择8，开奖号码为11，04，09，05，08，按开奖号码的数字大小排列为04，05，08，09，11，中间数08，即为中奖。',
                    help: '从3-9中选择1个号码进行购买，所选号码与5个开奖号码按照大小顺序排列后的第3个号码相同，即为中奖。'
                }
            },
            wf_rx_fs: {
                title: '任选复式',
                row: {
                    '任选复式': ['310005', '42', '48', '50', '52', '55', '57', '59']
                },
                '310005': {     //任选一中一复式
                    type: 'select',
                    param: {'titles': {yi: "选一中一"}, begin: 1, end: 11, row_num_count: 11, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 1, num_separator: ',', row_separator: '-'},
                    explain: '从01-11中任意选择1个或1个以上号码。',
                    example: '如：选择05，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11共11个号码中选择1个号码进行购买，只要当期顺序摇出的5个开奖号码中包含所选号码，即为中奖。'
                },
                '42': {     //任选二中二复式
                    type: 'select',
                    param: {'titles': {er: "选二中二"}, begin: 1, end: 11, row_num_count: 11, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 2, num_separator: ',', row_separator: '-'},
                    explain: '从01-11中任意选择2个或2个以上号码。',
                    example: '如：选择05 04，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11共11个号码中选择2个号码进行购买，只要当期顺序摇出的5个开奖号码中包含所选号码，即为中奖。'
                },
                '48': {     //任选三中三复式
                    type: 'select',
                    param: {'titles': {san: "选三中三"}, begin: 1, end: 11, row_num_count: 11, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 3, num_separator: ',', row_separator: '-'},
                    explain: '从01-11中任意选择3个或3个以上号码。',
                    example: '如：选择05 04 11，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11共11个号码中选择3个号码进行购买，只要当期顺序摇出的5个开奖号码中包含所选号码，即为中奖。'
                },
                '50': {     //任选四中四复式
                    type: 'select',
                    param: {'titles': {si: "选四中四"}, begin: 1, end: 11, row_num_count: 11, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 4, num_separator: ',', row_separator: '-'},
                    explain: '从01-11中任意选择4个或4个以上号码。',
                    example: '如：选择05 04 08 03，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11共11个号码中选择4个号码进行购买，只要当期顺序摇出的5个开奖号码中包含所选号码，即为中奖。'
                },
                '52': {     //任选五中五复式
                    type: 'select',
                    param: {'titles': {wu: "选五中五"}, begin: 1, end: 11, row_num_count: 11, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 5, num_separator: ',', row_separator: '-'},
                    explain: '从01-11中任意选择5个或5个以上号码。',
                    example: '如：选择05 04 11 03 08，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11共11个号码中选择5个号码进行购买，只要当期顺序摇出的5个开奖号码中包含所选号码，即为中奖。'
                },
                '55': {     //任选六中五复式
                    type: 'select',
                    param: {'titles': {liu: "选六中五"}, begin: 1, end: 11, row_num_count: 11, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 6, num_separator: ',', row_separator: '-'},
                    explain: '从01-11中任意选择6个或6个以上号码。',
                    example: '如：选择05 10 04 11 03 08，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11共11个号码中选择6个号码进行购买，只要当期顺序摇出的5个开奖号码中包含所选号码，即为中奖。'
                },
                '57': {     //任选七中五复式
                    type: 'select',
                    param: {'titles': {qi: "选七中五"}, begin: 1, end: 11, row_num_count: 11, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 7, num_separator: ',', row_separator: '-'},
                    explain: '从01-11中任意选择7个或7个以上号码。',
                    example: '如：选择05 04 10 11 03 08 09，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11共11个号码中选择7个号码进行购买，只要当期顺序摇出的5个开奖号码中包含所选号码，即为中奖。'
                },
                '59': {     //任选八中五复式
                    type: 'select',
                    param: {'titles': {ba: "选八中五"}, begin: 1, end: 11, row_num_count: 11, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 8, num_separator: ',', row_separator: '-'},
                    explain: '从01-11中任意选择8个或8个以上号码。',
                    example: '如：选择05 04 11 03 08 10 09 01，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11共11个号码中选择8个号码进行购买，只要当期顺序摇出的5个开奖号码中包含所选号码，即为中奖。'
                }
            },
            wf_rx_ds: {
                title: '任选单式',
                row: {
                    '任选单式': ['310006', '320006', '330006', '340006', '350006', '360006', '370006', '380006']
                },
                '310006': {     //任选一中一单式
                    type: 'input',
                    param: {},
                    calculate: {base_len: 1, check_type: 0, num_separator: ' '},
                    explain: '手动输入号码，从01-11中任意输入1个号码组成一注。',
                    example: '如：输入05，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11输入1个号码进行购买，只要当期顺序摇出的5个开奖号码中包含输入号码，即为中奖。'
                },
                '320006': {     //任选二中二单式
                    type: 'input',
                    param: {},
                    calculate: {base_len: 2, check_type: 1, num_separator: ' '},
                    explain: '手动输入号码，从01-11中任意输入2个号码组成一注。',
                    example: '如：输入05 04，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11输入2个号码进行购买，只要当期顺序摇出的5个开奖号码中包含输入号码，即为中奖。'
                },
                '330006': {     //任选三中三单式
                    type: 'input',
                    param: {},
                    calculate: {base_len: 3, check_type: 1, num_separator: ' '},
                    explain: '手动输入号码，从01-11中任意输入3个号码组成一注。',
                    example: '如：输入05 04 11，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11输入3个号码进行购买，只要当期顺序摇出的5个开奖号码中包含输入号码，即为中奖。'
                },
                '340006': {     //任选四中四单式
                    type: 'input',
                    param: {},
                    calculate: {'base_len': 4, check_type: 1, num_separator: ' '},
                    explain: '手动输入号码，从01-11中任意输入4个号码组成一注。',
                    example: '如：输入05 04 08 03，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11输入4个号码进行购买，只要当期顺序摇出的5个开奖号码中包含输入号码，即为中奖。'
                },
                '350006': {     //任选五中五单式
                    type: 'input',
                    param: {},
                    calculate: {base_len: 5, check_type: 1, num_separator: ' '},
                    explain: '手动输入号码，从01-11中任意输入5个号码组成一注。',
                    example: '如：输入05 04 11 03 08，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11输入5个号码进行购买，只要当期顺序摇出的5个开奖号码中包含输入号码，即为中奖。'
                },
                '360006': {     //任选六中五单式
                    type: 'input',
                    param: {},
                    calculate: {base_len: 6, check_type: 1, num_separator: ' '},
                    explain: '手动输入号码，从01-11中任意输入6个号码组成一注。',
                    example: '如：输入05 10 04 11 03 08，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11输入6个号码进行购买，只要当期顺序摇出的5个开奖号码中包含输入号码，即为中奖。'
                },
                '370006': {     //任选七中五单式
                    type: 'input',
                    param: {},
                    calculate: {base_len: 7, check_type: 1, num_separator: ' '},
                    explain: '手动输入号码，从01-11中任意输入7个号码组成一注。',
                    example: '如：输入05 04 10 11 03 08 09，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11输入7个号码进行购买，只要当期顺序摇出的5个开奖号码中包含输入号码，即为中奖。'
                },
                '380006': {     //任选八中五单式
                    type: 'input',
                    param: {},
                    calculate: {base_len: 8, check_type: 1, num_separator: ' '},
                    explain: '手动输入号码，从01-11中任意输入8个号码组成一注。',
                    example: '如：输入05 04 11 03 08 10 09 01，开奖号码为08 04 11 05 03，即为中奖。',
                    help: '从01-11输入8个号码进行购买，只要当期顺序摇出的5个开奖号码中包含输入号码，即为中奖。'
                }
            },
            wf_rx_dt: {
                title: '任选胆拖',
                row: {
                    '任选胆拖': ['43', '49', '51', '53', '56', '58'/*, '60'*/]
                },
                '43': {     //任选二胆拖
                    type: 'select',
                    param: {
                        titles: {dan: "胆码", tuo: "拖码"},
                        begin: 1,
                        end: 11,
                        row_num_count: 11,
                        selector: 2,
                        selector_index: {1: 1}
                    },
                    calculate: {
                        method: 'formula_dt',
                        limit_row: 0,
                        limit_rule: 'no_repeat',
                        base_len: 1,
                        num_separator: ',',
                        row_separator: '-'
                    },
                    explain: '从01-11中，选取2个及以上的号码进行投注，每注需至少包括1个胆码及1个拖码。',
                    example: '如：选择胆码 08，选择拖码 06，开奖号码为 06 08 11 09 02，即为中奖。',
                    help: '分别从胆码和拖码的01-11中，至少选择1个胆码和1个拖码组成一注，只要当期顺序摇出的5个开奖号码中同时包含所选的1个胆码和1个拖码，所选胆码必须全中，即为中奖。'
                },
                '49': {     //任选三胆拖
                    type: 'select',
                    param: {
                        titles: {dan: "胆码", tuo: "拖码"},
                        begin: 1,
                        end: 11,
                        row_num_count: 11,
                        selector: 2,
                        selector_index: {1: 1}
                    },
                    calculate: {
                        method: 'formula_dt',
                        limit_row: 0,
                        limit_rule: 'no_repeat',
                        base_len: 2,
                        num_separator: ',',
                        row_separator: '-'
                    },
                    explain: '从01-11中，选取3个及以上的号码进行投注，每注需至少包括1个胆码及2个拖码。',
                    example: '如：选择胆码 08，选择拖码 06 11，开奖号码为 06 08 11 09 02，即为中奖。',
                    help: '分别从胆码和拖码的01-11中，至少选择1个胆码和2个拖码组成一注，只要当期顺序摇出的5个开奖号码中同时包含所选的1个胆码和2个拖码，所选胆码必须全中，即为中奖。'
                },
                '51': {     //任选四胆拖
                    type: 'select',
                    param: {
                        titles: {dan: "胆码", tuo: "拖码"},
                        begin: 1,
                        end: 11,
                        row_num_count: 11,
                        selector: 2,
                        selector_index: {1: 1}
                    },
                    calculate: {
                        method: 'formula_dt',
                        limit_row: 0,
                        limit_rule: 'no_repeat',
                        base_len: 3,
                        num_separator: ',',
                        row_separator: '-'
                    },
                    explain: '从01-11中，选取4个及以上的号码进行投注，每注需至少包括1个胆码及3个拖码。',
                    example: '如：选择胆码 08，选择拖码 06 09 11，开奖号码为 06 08 11 09 02，即为中奖。',
                    help: '分别从胆码和拖码的01-11中，至少选择1个胆码和3个拖码组成一注，只要当期顺序摇出的5个开奖号码中同时包含所选的1个胆码和3个拖码，所选胆码必须全中，即为中奖。'
                },
                '53': {     //任选五胆拖
                    type: 'select',
                    param: {
                        titles: {dan: "胆码", tuo: "拖码"},
                        begin: 1,
                        end: 11,
                        row_num_count: 11,
                        selector: 2,
                        selector_index: {1: 1}
                    },
                    calculate: {
                        method: 'formula_dt',
                        limit_row: 0,
                        limit_rule: 'no_repeat',
                        base_len: 4,
                        num_separator: ',',
                        row_separator: '-'
                    },
                    explain: '从01-11中，选取5个及以上的号码进行投注，每注需至少包括1个胆码及4个拖码。',
                    example: '如：选择胆码 08，选择拖码 02 06 09 11，开奖号码为  06 08 11 09 02，即为中奖。',
                    help: '分别从胆码和拖码的01-11中，至少选择1个胆码和4个拖码组成一注，只要当期顺序摇出的5个开奖号码中同时包含所选的1个胆码和4个拖码，所选胆码必须全中，即为中奖。'
                },
                '56': {     //任选六胆拖
                    type: 'select',
                    param: {
                        titles: {dan: "胆码", tuo: "拖码"},
                        begin: 1,
                        end: 11,
                        row_num_count: 11,
                        selector: 2,
                        selector_index: {1: 1}
                    },
                    calculate: {
                        method: 'formula_dt',
                        limit_row: 0,
                        limit_rule: 'no_repeat',
                        base_len: 5,
                        num_separator: ',',
                        row_separator: '-'
                    },
                    explain: '从01-11中，选取6个及以上的号码进行投注，每注需至少包括1个胆码及5个拖码。',
                    example: '如：选择胆码 08，选择拖码 01 02 05 06 09 11，开奖号码为 06 08 11 09 02，即为中奖。',
                    help: '分别从胆码和拖码的01-11中，至少选择1个胆码和5个拖码组成一注，只要当期顺序摇出的5个开奖号码同时存在于胆码和拖码的任意组合中，即为中奖。'
                },
                '58': {     //任选七胆拖
                    type: 'select',
                    param: {
                        titles: {dan: "胆码", tuo: "拖码"},
                        begin: 1,
                        end: 11,
                        row_num_count: 11,
                        selector: 2,
                        selector_index: {1: 1}
                    },
                    calculate: {
                        method: 'formula_dt',
                        limit_row: 0,
                        limit_rule: 'no_repeat',
                        base_len: 6,
                        num_separator: ',',
                        row_separator: '-'
                    },
                    explain: '从01-11中，选取7个及以上的号码进行投注，每注需至少包括1个胆码及6个拖码。',
                    example: '如：选择胆码 08，选择拖码 01 02 05 06 07 09 11，开奖号码为 06 08 11 09 02，即为中奖。',
                    help: '分别从胆码和拖码的01-11中，至少选择1个胆码和6个拖码组成一注，只要当期顺序摇出的5个开奖号码同时存在于胆码和拖码的任意组合中，即为中奖。'
                },
                '60': {     //任选八胆拖
                    type: 'select',
                    param: {
                        titles: {dan: "胆码", tuo: "拖码"},
                        begin: 1,
                        end: 11,
                        row_num_count: 11,
                        selector: 2,
                        selector_index: {1: 1}
                    },
                    calculate: {
                        method: 'formula_dt',
                        limit_row: 0,
                        limit_rule: 'no_repeat',
                        base_len: 7,
                        num_separator: ',',
                        row_separator: '-'
                    },
                    explain: '从01-11中，选取8个及以上的号码进行投注，每注需至少包括1个胆码及7个拖码。',
                    example: '如：选择胆码 08，选择拖码 01 02 03 05 06 07 09 11，开奖号码为 06 08 11 09 02，即为中奖。',
                    help: '分别从胆码和拖码的01-11中，至少选择1个胆码和7个拖码组成一注，只要当期顺序摇出的5个开奖号码同时存在于胆码和拖码的任意组合中，即为中奖。'
                }
            }
        }
    },
    //彩种类型4     快乐十分
    LOTTERY_4: {
        num_min: 1,
        num_max: 20,
        num_len: 2,
        run_num_length: 8,
        wf_class: {
            kl_sf: {
                title: '快乐十分',
                row: {
                    '': ['61', '62', '63', '64', '66', '67', '65', '68', '69', '70']
                },
                '61': {//首位数投
                    type: 'select',
                    param: {titles: {yi: "首位"}, begin: 1, end: 18, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_num_count', num_separator: ',', row_separator: '-'},
                    explain: '从01至18中任选1个,投注号码与开奖号码第一位相同即中奖。',
                    example: '从01至18中任选1个,投注号码与开奖号码第一位相同即中奖。',
                    help: '从01至18中任选1个,投注号码与开奖号码第一位相同即中奖。'
                },
                '62': {//首位红投
                    type: 'select',
                    param: {'titles': {yi: "首位"}, begin: 19, end: 20, row_num_count: 10, selector: 0},
                    calculate: {method: 'formula_num_count', num_separator: ',', row_separator: '-'},
                    explain: '19，20为红号，从这两个号码任选一个投注，开奖号码第一位是红号（19或20）即中奖。',
                    example: '19，20为红号，从这两个号码任选一个投注，开奖号码第一位是红号（19或20）即中奖。',
                    help: '19，20为红号，从这两个号码任选一个投注，开奖号码第一位是红号（19或20）即中奖。'
                },
                '63': {//二连直
                    type: 'select',
                    param: {'titles': {qw: "前位", hou: '后位'}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中任选连续两位,投注号码与开奖号码任意连续两位数字、顺序均相同即中奖。',
                    example: '从20个号码中任选连续两位,投注号码与开奖号码任意连续两位数字、顺序均相同即中奖。',
                    help: '从20个号码中任选连续两位,投注号码与开奖号码任意连续两位数字、顺序均相同即中奖。'
                },
                '64': {//二连组
                    type: 'select',
                    param: {'titles': {er: "二连组"}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 2, num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中任选2个,投注号与开奖号任意连续两位数字相同(顺序不限)即中。',
                    example: '从20个号码中任选2个,投注号与开奖号任意连续两位数字相同(顺序不限)即中。',
                    help: '从20个号码中任选2个,投注号与开奖号任意连续两位数字相同(顺序不限)即中。'
                },
                '65': {//快乐二
                    type: 'select',
                    param: {'titles': {er: "快乐二"}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 2, num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中任选2个,投注号码与开奖号码任意两位相同即中奖。',
                    example: '从20个号码中任选2个,投注号码与开奖号码任意两位相同即中奖。',
                    help: '从20个号码中任选2个,投注号码与开奖号码任意两位相同即中奖。'
                },
                '66': {//前三直
                    type: 'select',
                    param: {
                        'titles': {yi: "第一位", er: "第二位", san: "第三位"},
                        begin: 1,
                        end: 20,
                        row_num_count: 10,
                        selector: 2
                    },
                    calculate: {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中猜开奖号码前三位,投注号码与开奖号码前三位数字、顺序均相同即中奖。',
                    example: '从20个号码中猜开奖号码前三位,投注号码与开奖号码前三位数字、顺序均相同即中奖。',
                    help: '从20个号码中猜开奖号码前三位,投注号码与开奖号码前三位数字、顺序均相同即中奖。'
                },
                '67': {//前三组
                    type: 'select',
                    param: {'titles': {san: "前三组"}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 3, num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中猜开奖号码的前三位,投注号与开奖号前三位数字相同(顺序不限)即中。',
                    example: '从20个号码中猜开奖号码的前三位,投注号与开奖号前三位数字相同(顺序不限)即中。',
                    help: '从20个号码中猜开奖号码的前三位,投注号与开奖号前三位数字相同(顺序不限)即中。'
                },
                '68': {//快乐三
                    type: 'select',
                    param: {'titles': {san: "快乐三"}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 3, num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中任选3个,投注号码与开奖号码任意三位相同即中奖。',
                    example: '从20个号码中任选3个,投注号码与开奖号码任意三位相同即中奖。',
                    help: '从20个号码中任选3个,投注号码与开奖号码任意三位相同即中奖。'
                },
                '69': {//快乐四
                    type: 'select',
                    param: {'titles': {si: "快乐四"}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 4, num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中任选4个,投注号码与开奖号码任意四位相同即中奖。',
                    example: '从20个号码中任选4个,投注号码与开奖号码任意四位相同即中奖。',
                    help: '从20个号码中任选4个,投注号码与开奖号码任意四位相同即中奖。'
                },
                '70': {//快乐五
                    type: 'select',
                    param: {'titles': {wu: "快乐五"}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 5, num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中任选5个,投注号码与开奖号码任意五位相同即中奖。',
                    example: '从20个号码中任选5个,投注号码与开奖号码任意五位相同即中奖。',
                    help: '从20个号码中任选5个,投注号码与开奖号码任意五位相同即中奖。'
                }
            }
        }
    },
    //彩种类型6 六合彩
    LOTTERY_6: {
        num_min: 1,
        num_max: 49,
        num_len: 2,
        bet_money: 10,
        run_num_length: 7,
        wf_class: {
            lhc: {
                title: '六合彩',
                row: {
                    '号码': ['81', '82', '92', '86', '88', '89', '90', '91'],
                    '生肖': ['93', '84', '87'],
                    '趣味': ['83', '85']
                },
                '81': {     //特码直选(A)
                    type: 'select',
                    param: {
                        titles: {lhc: "特码"},
                        begin: 1,
                        end: 49,
                        row_num_count: 10,
                        selector: 2,
                        show_title: 'get_lhc_odds',
                        value_type: 1,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '特码指的是六合彩开奖序列号的最后一个号。',
                    example: '特码直选(A)。',
                    help: '特码直选(A)。'
                },
                '82': {     //特码直选(B)
                    type: 'select',
                    param: {
                        titles: {lhc: "特码"},
                        begin: 1,
                        end: 49,
                        row_num_count: 10,
                        selector: 2,
                        show_title: 'get_lhc_odds',
                        value_type: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    'explain': '特码指的是六合彩开奖序列号的最后一个号。',
                    'example': '特码直选(B)。',
                    'help': '特码直选(B)。'
                },
                '83': {     //特码大小单双
                    type: 'select',
                    param: {'titles': {lhc: "大小单双"}, cs: 'lhc_dx_ds', selector: 2},
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '特小:开出之特码为(01~24).特大:开出之特码为(25~48).和局:特码为49时.特单:特码为[单数].特双:特码为[双数].和局:特码为49时。',
                    example: '特码大小单双。',
                    help: '特码大小单双。'
                },
                '84': {     //四肖
                    type: 'select',
                    param: {'titles': {lhc: "生肖"}, cs: 'lhc_sx', selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 4, num_separator: ','},
                    explain: '四肖。',
                    example: '四肖。',
                    help: '四肖。'
                },
                '85': {     //平特色波
                    type: 'select',
                    param: {titles: {lhc: "色波"}, cs: 'lhc_sb', selector: 2},
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '特码色波:香港六合彩49个号码球分别有红,蓝,绿三种颜色,以特码开出的颜色和投注的颜色相同视为中奖.',
                    example: '平特色波。',
                    help: '颜色代表如下：<br>红波:1,2,7,8,12,13,18,19,23,24,29,30,34,35,40,45,46.<br>蓝波:3,4,9,10,14,15,20,25,26,31,36,37,41,42,47,48.<br>绿波:5,6,11,16,17,21,22,27,28,32,33,38,39,43,44,49.'
                },
                '86': {     //平特尾数
                    type: 'select',
                    param: {
                        'titles': {lhc: "尾数"},
                        begin: 0,
                        end: 9,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number',
                        num_len: 1
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '平特尾数。',
                    example: '平特尾数。',
                    help: '平特尾数。'
                },
                '87': {     //六肖
                    type: 'select',
                    param: {titles: {lhc: "六肖"}, cs: 'lhc_sx', selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 6, num_separator: ','},
                    explain: '挑选6个生肖(排列如同生肖)为一个组合，并选择开奖号码的特码是否在此组合内.',
                    example: '若选择【中】且开奖号码的特码亦在此组合内，则视为中奖，若选择【不中】且开奖号码的特码亦不在此组合内，即视为中奖，若当期特码开出 49 号，则视为和局；其余情形视为不中奖.',
                    help: '若选择【中】且开奖号码的特码亦在此组合内，则视为中奖，若选择【不中】且开奖号码的特码亦不在此组合内，即视为中奖，若当期特码开出 49 号，则视为和局；其余情形视为不中奖.'
                },
                '88': {     //五不中
                    type: 'select',
                    param: {
                        'titles': {lhc: "五不中"},
                        begin: 1,
                        end: 49,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_zx_fs', base_len: 5, num_separator: ','},
                    explain: '挑选5个号码为一投注组合进行下注。当期开出的7个开奖号码都没有在该下注组合中，即视为中奖。',
                    example: '如下注组合为1-2-3-4-5，开奖号码为6，7，8，9，10，11，12，即为中奖，如果开奖号码为5，6，7，8，9，10，11，那么为不中奖。',
                    help: '每个号码都有自己的赔率，下注组合的总赔率，取该组合号码的最低赔率为总赔率。'
                },
                '89': {     //三全中
                    type: 'select',
                    param: {
                        'titles': {lhc: "三全中"},
                        begin: 1,
                        end: 49,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_zx_fs', base_len: 3, num_separator: ','},
                    explain: '选择投注号码每三个号码为一组(号码需三个号以上，少于三个号码不成立)',
                    example: '对奖号是以正码对奖〈1～6号不含特码〉，如三个号码都是在开奖号码的正码里，视为中奖，其他情形视为不中奖。',
                    help: '对奖号是以正码对奖〈1～6号不含特码〉，如三个号码都是在开奖号码的正码里，视为中奖，其他情形视为不中奖。'
                },
                '90': {     //二全中
                    type: 'select',
                    param: {
                        'titles': {lhc: "二全中"},
                        begin: 1,
                        end: 49,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_zx_fs', base_len: 2, num_separator: ','},
                    explain: '选择投注号码每二个号码为一组(号码需二个号以上，少于二个号码不成立).',
                    example: '如二个号码都是在开奖号码的正码，视为中奖，其他情形视为不中奖。',
                    help: '例：11， 17 二个号码都是开在正码里，视为中奖，如果二个号码一个中在正码一个中特码，此情形视为不中奖。'
                },
                '91': {     //三中二
                    type: 'select',
                    param: {
                        'titles': {lhc: "三中二"},
                        begin: 1,
                        end: 49,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_zx_fs', base_len: 3, num_separator: ','},
                    explain: '中二：选择投注号码每三个号码为一组(号码需三个号以上，少于三个号码不成立)。',
                    example: '如中的二个号码都是在开奖号码的正码里，为三中二视为中奖。中三：选择投注号码每三个号码为一组〈号码需三个号以上，少于三个号码不成立〉，如中的三个号码都是在开奖号码的正码里，为三中二之中三视为中奖。 除中二、中三外其他情形视为不中奖。',
                    help: '例：11，17，18 为一组投注号码，开奖号码中有11，17 两个正码〈没有18号码〉，为三中二中奖，赔率为三中二的赔率，如果11， 17 ，18三个号码都是开奖之正码，视为三中二之中三，赔率为三中二之中三的赔率，如只中一个号或是没中任何号码，此情形视为不中奖。'
                },
                '92': {     //平码直选
                    type: 'select',
                    param: {
                        'titles': {lhc: "平码直选"},
                        begin: 1,
                        end: 49,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '所选号码与开奖号码前6位相同，即为中奖。',
                    example: '所选号码与开奖号码前6位相同，即为中奖。',
                    help: '所选号码与开奖号码前6位相同，即为中奖。'
                },
                '93': {     //平特一肖
                    type: 'select',
                    param: {'titles': {lhc: "平特一肖"}, cs: 'lhc_sx', selector: 2},
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '指开奖7个号码中含有所属生肖的一个或多个号码，但派彩只派一次，即不论同生肖号码出现一个或多个号码都只派彩一次。',
                    example: '指开奖 7 个号码中含有所属生肖的一个或多个号码，但派彩只派一次，即不论同生肖号码出现一个或多个号码都只派彩一次。',
                    help: '指开奖 7 个号码中含有所属生肖的一个或多个号码，但派彩只派一次，即不论同生肖号码出现一个或多个号码都只派彩一次。'
                }
            }
        }
    },
    //彩种类型9 快三
    LOTTERY_9: {
        num_min: 1,
        num_max: 6,
        num_len: 1,
        run_num_length: 3,
        run_num_css: 'gr_d',
        wf_class: {
            wf_ebt: {
                title: '二不同号',
                row: {
                    '二不同号': ['500001', '500002', '500003']
                },
                '500001': {//二不同标准
                    type: 'select',
                    param: {'titles': {hao: "号码"}, begin: 1, end: 6, row_num_count: 6, css: 'dice'},
                    calculate: {method: 'formula_zx_fs', base_len: 2, num_separator: ','},
                    explain: '从1-6中任意选择2个或2个以上号码。',
                    example: '投注方案：2,5<br>开奖号码中出现：1个2、1个5(顺序不限)，即为中奖。',
                    help: '从1-6中任意选择2个号码组成一注，顺序不限。开奖号码中出现所选的两个号码即为中奖。'
                },
                '500002': {//二不同单式
                    type: 'input',
                    param: {},
                    calculate: {base_len: 2, check_type: 1, to_value: 'insert_comma'},
                    explain: '手动输入号码，至少输入一个由1-6中两个不同的数字组成一注的号码。',
                    example: '投注方案：5,6<br>开奖号码：536，即中奖。',
                    help: '开奖号码中至少包含所输入的两个数字即为中奖。'
                },
                '500003': {//二不同胆拖
                    type: 'select',
                    param: {'titles': {dan: "胆码", tuo: '拖码'}, begin: 1, end: 6, row_num_count: 6, css: 'dice'},
                    calculate: {
                        method: 'formula_dt',
                        limit_row: 0,
                        limit_rule: 'no_repeat',
                        base_len: 1,
                        num_separator: ',',
                        row_separator: '-'
                    },
                    explain: '从1-6中任意选择1个胆码以及1个以上的号码作为拖码。',
                    example: '二不同胆拖',
                    help: '从1-6中选择一个胆码和至少一个拖码，如果开奖号码中不重复数字至少包含胆码所选号码即为中奖。'
                }
            },
            wf_et: {
                title: '二同号',
                row: {
                    '单选': ['500004', '500005'],
                    '复选': ['500006']
                },
                '500004': {//二同号标准
                    type: 'select',
                    param: {'titles': {et: "二同号", bt: "不同号"}, 'cs': 'ks_et_bz', css: 'dice'},
                    calculate: {
                        method: 'formula_num_multiply',
                        limit_row: 0,
                        limit_rule: 'no_repeat',
                        num_separator: ',',
                        row_separator: '-'
                    },
                    explain: '选择1个对子（11,22,33,44,55,66）和1个不同号码(1,2,3,4,5,6)投注。',
                    example: '投注方案：112<br>开奖号码为112,121,211中任意一个，即为中奖。',
                    help: '选择一个对子(11,22,33,44,55,66)和一个不同号码(1,2,3,4,5,6)投注，选号与开奖号码一致即为中奖。'
                },
                '500005': {//二同号单式
                    type: 'input',
                    param: {},
                    calculate: {base_len: 3, check_type: 2, to_value: 'insert_comma', row_separator: '-'},
                    explain: '手动输入号码，至少输入一个由1-6中2个数字组成一注的号码。',
                    example: '投注方案：112<br>开奖号码为112,121,211中任意一个，即中奖。',
                    help: '手动输入号码，至少输入一个三位数号码，选号与开奖号码一致即中奖。'
                },
                '500006': {//二同号复选
                    type: 'select',
                    param: {'titles': {tong: "复选"}, 'cs': 'ks_et_fs', css: 'dice'},
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '选择对子(11*,22*,33*,44*,55*,66*)进行投注。',
                    example: '投注方案：11*<br>开奖号码：112,211,121，即中奖。',
                    help: '选择对子(11*,22*,33*,44*,55*,66*)投注，开奖号码中包含选择的对子即中奖。'
                }
            },
            wf_sbt: {
                title: '三不同号',
                row: {
                    '三不同号': ['500007', '500008', '500009', '500010']
                },
                '500007': {//三不同标准
                    type: 'select',
                    param: {'titles': {hao: "号码"}, begin: 1, end: 6, row_num_count: 6, css: 'dice'},
                    calculate: {method: 'formula_zx_fs', base_len: 3, num_separator: ','},
                    explain: '选择任意三个或以上的号码进行投注。',
                    example: '投注方案：2,5,6<br>开奖号码中出现：256,562,625(顺序不限)即中奖。',
                    help: '从1-6中任意选择3个(或以上)不相同号码组成一注，顺序不限，若其中三位与开奖号码相同即为中奖。'
                },
                '500008': {//三不同单式
                    type: 'input',
                    param: {},
                    calculate: {base_len: 3, check_type: 1, to_value: 'insert_comma'},
                    explain: '对三个各不相同的号码进行投注。',
                    example: '投注方案：256<br>开奖号码中出现：1个2、1个5、1个6(顺序不限)，即中奖。',
                    help: '从1-6中任意选择3个或3个以上各不相同号码组成一注，顺序不限，若开奖号码与所选号码相同，即为中奖。'
                },
                '500009': {//三不同胆拖
                    type: 'select',
                    param: {'titles': {dan: "胆码", tuo: '拖码'}, begin: 1, end: 6, row_num_count: 6, css: 'dice'},
                    calculate: {
                        method: 'formula_dt',
                        limit_row: 0,
                        limit_rule: 'no_repeat',
                        base_len: 2,
                        num_separator: ',',
                        row_separator: '-'
                    },
                    explain: '从1-6中任意选择1~2个胆码以及1个以上的号码作为拖码。',
                    example: '三不同胆拖',
                    help: '从1-6中选择1~2个胆码和至少一个拖码，如果开奖号码中至少包含胆码所选号码，即为中奖。'
                },
                '500010': {//三不同和值
                    type: 'select',
                    param: {
                        'titles': {he: "和值"},
                        begin: 6,
                        end: 15,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_value_add', value: 'ks_sbt', num_separator: '$'},
                    explain: '从6-15中任意选择1个或1个以上号码。',
                    example: '投注方案：和值9<br>开奖号码：234,423,342即为中奖',
                    help: '所选数值等于开奖号码相加之和，即为中奖。'
                }
            },
            wf_sth: {
                title: '三同号',
                row: {
                    '三同号': ['500011', '500012', '500013']
                },
                '500011': {//三同号单选
                    type: 'select',
                    param: {'titles': {dan: "单选"}, 'cs': 'ks_sth', css: 'dice'},
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '选择任意一组以上三位相同的号码。',
                    example: '投注方案：222<br>开奖号码为222，即为中奖。',
                    help: '从111,222,333,444,555,666中选择任意一组或一组以上号码进行投注，选号与开奖号码一致即为中奖。'
                },
                '500012': {//三同号通选
                    type: 'select',
                    param: {'titles': {tong: "通选"}, 'cs': 'ks_sth', css: 'dice'},
                    calculate: {method: 'fixed_one', limit_rule: 'for_all', value: '', num_separator: ','},
                    explain: '对所有三同号（111,222,333,444,555,666）进行投注。',
                    example: '投注方案：通选<br>开奖号码中出现：222或3个其他数字，即中奖。',
                    help: '投注后，开奖号码为任意数字的三重号，即为中奖。'
                },
                '500013': {//三连号通选
                    type: 'select',
                    param: {'titles': {tong: "通选"}, 'cs': 'ks_slh', css: 'dice'},
                    calculate: {method: 'fixed_one', limit_rule: 'for_all', value: '', num_separator: ','},
                    explain: '对所有三个相连的号码进行投注。',
                    example: '投注方案：三连号通选<br>开奖号码：123或324或345或456即中奖。',
                    help: '开奖号码为三连号(123,234,345,456)即为中奖。'
                }
            },
            wf_hz: {
                title: '和值',
                row: {
                    '和值': ['500014', '500029']
                },
                '500014': {//和值
                    type: 'select',
                    param: {
                        'titles': {value: "和值"},
                        begin: 3,
                        end: 18,
                        row_num_count: 8,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: '$'},
                    explain: '从3-18中任意选择1个或1个以上号码。',
                    example: '投注方案：和值4<br>开奖号码：112，即为中奖。',
                    help: '所选数值等于开奖号码三个数字相加之和，即为中奖。'
                },
                '500029': {
                    'type': 'select',
                    'param': {'titles': {yi:'和值'},'cs': 'ks_dx_ds', 'selector': 1},
                    'calculate': {'method': 'formula_num_multiply'},
                    explain: '大小单双',
                    example: '大小单双',
                    help: '大小单双'
                }
            }
        }
    },
    //彩种类型10    PK10
    LOTTERY_10: {
        num_min: 1,
        num_max: 10,
        num_len: 2,
        wf_class: {
            wf_one: {
                title: '猜第一',
                row: {
                    '猜第一': ['400001', '400021']
                },
                '400001': {     //猜冠军
                    type: 'select',
                    param: {
                        titles: {pk: "冠军"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '猜冠军',
                    example: '猜冠军',
                    help: '猜冠军'
                },
                '400021': {     //猜冠军
                    type: 'input',
                    param: {},
                    calculate: {base_len: 1, check_type: 0, num_separator: '~'},
                    explain: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    example: '猜冠军,输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    help: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)'
                }
            },
            wf_two: {
                title: '猜前二',
                row: {
                    '猜前二名': ['400002', '400022', '400012', '400032']
                },
                '400002': {     //猜亚军
                    type: 'select',
                    param: {
                        titles: {pk: "亚军"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '猜亚军',
                    example: '猜亚军',
                    help: '猜亚军'
                },
                '400022': {     //猜亚军
                    type: 'input',
                    param: {},
                    calculate: {base_len: 1, check_type: 0, num_separator: '~'},
                    explain: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    example: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    help: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)'
                },
                '400012': {        //猜前二名
                    type: 'select',
                    param: {
                        'titles': {yi: "冠军", er: "亚军"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    explain: '猜前二名',
                    example: '猜前二名',
                    help: '猜前二名'
                },
                '400032': {     //猜前二名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 2, check_type:0, num_separator: ' '},
                    explain: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    example: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    help: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)'
                }
            },
            wf_three: {
                title: '猜前三',
                row: {
                    '猜前三名': ['400003', '400023', '400013', '400033']
                },
                '400003': {     //猜季军
                    type: 'select',
                    param: {
                        titles: {pk: "季军"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '猜季军',
                    example: '猜季军',
                    help: '猜季军'
                },
                '400023': {     //猜季军
                    type: 'input',
                    param: {},
                    calculate: {base_len: 1, check_type: 0, num_separator: '~'},
                    explain: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    example: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    help: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)'
                },
                '400013': {        //猜前三名
                    type: 'select',
                    param: {
                        'titles': {yi: "冠军", er: "亚军", san: "季军"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    explain: '猜前三名',
                    example: '猜前三名',
                    help: '猜前三名'
                },
                '400033': {     //猜前三名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 3, check_type:0, num_separator: ' '},
                    explain: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    example: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    help: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)'
                }
            },
            wf_four: {
                title: '猜前四',
                row: {
                    '猜前四名': ['400004', '400024', '400014', '400034']
                },
                '400004': {     //猜第四名
                    type: 'select',
                    param: {
                        titles: {pk: "第四名"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '猜第四名',
                    example: '猜第四名',
                    help: '猜第四名'
                },
                '400024': {     //猜第四名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 1, check_type: 0, num_separator: '~'},
                    explain: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    example: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    help: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)'
                },
                '400014': {        //猜前四名
                    type: 'select',
                    param: {
                        'titles': {yi: "冠军", er: "亚军", san: "季军", si: "第四名"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    explain: '猜前四名',
                    example: '猜前四名',
                    help: '猜前四名'
                },
                '400034': {     //猜前四名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 4, check_type:0, num_separator: ' '},
                    explain: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    example: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    help: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)'
                }
            },
            wf_five: {
                title: '猜前五',
                row: {
                    '猜前五名': ['400005', '400025', '400015', '400035']
                },
                '400005': {     //猜第五名
                    type: 'select',
                    param: {
                        titles: {pk: "第五名"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '猜第五名',
                    example: '猜第五名',
                    help: '猜第五名'
                },
                '400025': {     //猜第五名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 1, check_type: 0, num_separator: '~'},
                    explain: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    example: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    help: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)'
                },
                '400015': {        //猜前五名
                    type: 'select',
                    param: {
                        'titles': {yi: "冠军", er: "亚军", san: "季军", si: "第四", wu: "第五名"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    explain: '猜前五名',
                    example: '猜前五名',
                    help: '猜前五名'
                },
                '400035': {     //猜前五名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 5, check_type:0, num_separator: ' '},
                    explain: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    example: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    help: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)'
                }
            },
            wf_six: {
                title: '猜前六',
                row: {
                    '猜前六名': ['400006', '400026', '400016', '400036']
                },
                '400006': {     //猜第六名
                    type: 'select',
                    param: {
                        titles: {pk: "第六名"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '猜第六名',
                    example: '猜第六名',
                    help: '猜第六名'
                },
                '400026': {     //猜第六名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 1, check_type: 0, num_separator: '~'},
                    explain: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    example: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    help: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)'
                },
                '400016': {        //猜前六名
                    type: 'select',
                    param: {
                        'titles': {yi: "冠军", er: "亚军", san: "季军", si: "第四", wu: "第五名", liu: "第六名"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    explain: '猜前六名',
                    example: '猜前六名',
                    help: '猜前六名'
                },
                '400036': {     //猜前六名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 6, check_type:0, num_separator: ' '},
                    explain: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    example: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    help: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)'
                }
            },
            wf_seven: {
                title: '猜第七',
                row: {
                    '猜前七名': ['400007', '400027', '400017', '400037']
                },
                '400007': {     //猜第七名
                    type: 'select',
                    param: {
                        titles: {pk: "第七名"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '猜第七名',
                    example: '猜第七名',
                    help: '猜第七名'
                },
                '400027': {     //猜第七名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 1, check_type: 0, num_separator: '~'},
                    explain: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    example: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    help: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)'
                },
                '400017': {        //猜前七名
                    type: 'select',
                    param: {
                        'titles': {
                            yi: "冠军",
                            er: "亚军",
                            san: "季军",
                            si: "第四",
                            wu: "第五名",
                            liu: "第六名",
                            qi: "第七名"
                        }, begin: 1, end: 10, row_num_count: 10, selector: 2, value: 'number'
                    },
                    calculate: {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    explain: '猜前七名',
                    example: '猜前七名',
                    help: '猜前七名'
                },
                '400037': {     //猜前七名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 7, check_type:0, num_separator: ' '},
                    explain: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    example: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    help: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)'
                }
            },
            wf_eight: {
                title: '猜前八',
                row: {
                    '猜前八名': ['400008', '400028', '400018', '400038']
                },
                '400008': {     //猜第八名
                    type: 'select',
                    param: {
                        titles: {pk: "第八名"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '猜第八名',
                    example: '猜第八名',
                    help: '猜第八名'
                },
                '400028': {     //猜第八名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 1, check_type: 0, num_separator: '~'},
                    explain: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    example: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    help: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)'
                },
                '400018': {        //猜前八名
                    type: 'select',
                    param: {
                        'titles': {
                            yi: "冠军",
                            er: "亚军",
                            san: "季军",
                            si: "第四",
                            wu: "第五名",
                            liu: "第六名",
                            qi: "第七名",
                            ba: "第八名"
                        }, begin: 1, end: 10, row_num_count: 10, selector: 2, value: 'number'
                    },
                    calculate: {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    explain: '猜前八名',
                    example: '猜前八名',
                    help: '猜前八名'
                },
                '400038': {     //猜前八名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 8, check_type:0, num_separator: ' '},
                    explain: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    example: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    help: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)'
                }
            },
            wf_nine: {
                title: '猜前九',
                row: {
                    '猜前九名': ['400009', '400029', '400019', '400039']
                },
                '400009': {     //猜第九名
                    type: 'select',
                    param: {
                        titles: {pk: "第九名"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '猜第九名',
                    example: '猜第九名',
                    help: '猜第九名'
                },
                '400029': {     //猜第九名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 1, check_type: 0, num_separator: '~'},
                    explain: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    example: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    help: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)'
                },
                '400019': {        //猜前九名
                    type: 'select',
                    param: {
                        'titles': {
                            yi: "冠军",
                            er: "亚军",
                            san: "季军",
                            si: "第四",
                            wu: "第五名",
                            liu: "第六名",
                            qi: "第七名",
                            ba: "第八名",
                            jiu: "第九名"
                        }, begin: 1, end: 10, row_num_count: 10, selector: 2, value: 'number'
                    },
                    calculate: {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    explain: '猜前九名',
                    example: '猜前九名',
                    help: '猜前九名'
                },
                '400039': {     //猜前九名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 9, check_type:0, num_separator: ' '},
                    explain: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    example: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    help: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)'
                }
            },
            wf_ten: {
                title: '猜前十',
                row: {
                    '猜前十名': ['400010', '400030', '400020', '400040']
                },
                '400010': {     //猜第十名
                    type: 'select',
                    param: {
                        titles: {pk: "第十名"},
                        begin: 1,
                        end: 10,
                        row_num_count: 10,
                        selector: 2,
                        value: 'number'
                    },
                    calculate: {method: 'formula_num_count', num_separator: ','},
                    explain: '猜第十名',
                    example: '猜第十名',
                    help: '猜第十名'
                },
                '400030': {     //猜第十名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 1, check_type: 0, num_separator: '~'},
                    explain: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    example: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)',
                    help: '输入选择的号码,每个号码之间用逗号隔开(1,2,3)'
                },
                '400020': {        //猜前十名
                    type: 'select',
                    param: {
                        'titles': {
                            yi: "冠军",
                            er: "亚军",
                            san: "季军",
                            si: "第四",
                            wu: "第五名",
                            liu: "第六名",
                            qi: "第七名",
                            ba: "第八名",
                            jiu: "第九名",
                            shi: "第十名"
                        }, begin: 1, end: 10, row_num_count: 10, selector: 2, value: 'number'
                    },
                    calculate: {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    explain: '猜前十名',
                    example: '猜前十名',
                    help: '猜前十名'
                },
                '400040': {     //猜前九名
                    type: 'input',
                    param: {},
                    calculate: {base_len: 10, check_type:0, num_separator: ' '},
                    explain: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    example: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)',
                    help: '输入选择的号码,每个号码之间用空格隔开,每组号码用逗号或分号或回车隔开(1 2,3 4)'
                }
            },
            wf_dwd: {
                title: '定位胆',
                row: {
                    '定位胆': ['400041']
                },
                '400041': {     //猜第十名
                    type: 'select',
                    param: {
                        titles: {yi:"第一",er:'第二',san:'第三',si:'第四',wu:'第五',liu:'第六',qi:'第七',ba:'第八',jiu:'第九',shi:'第十'},
                        begin:1,end:10,row_num_count:10,selector:2
                    },
                    calculate: {method:'formula_num_count',num_separator:',',row_separator:'-'},
                    explain: '定位胆',
                    example: '定位胆',
                    help: '定位胆'
                }
            },
            wf_dxds: {
                title: '大小单双',
                row: {
                    '定位胆': ['400051', '400052', '400053']
                },
                '400051': {     //冠军大小单双
                    'type': 'select',
                    'param': {'titles': {yi:'冠军'},'cs': 'dx_ds', 'selector': 1},
                    'calculate': {'method': 'formula_num_multiply'},
                    explain: '冠军大小单双',
                    example: '冠军大小单双',
                    help: '冠军大小单双'
                },
                '400052': {     //亚军大小单双
                    'type': 'select',
                    'param': {'titles': {yi:'亚军'},'cs': 'dx_ds', 'selector': 1},
                    'calculate': {'method': 'formula_num_multiply'},
                    explain: '亚军大小单双',
                    example: '亚军大小单双',
                    help: '亚军大小单双'
                },
                '400053': {     //季军大小单双
                    'type': 'select',
                    'param': {'titles': {yi:'季军'},'cs': 'dx_ds', 'selector': 1},
                    'calculate': {'method': 'formula_num_multiply'},
                    explain: '季军大小单双',
                    example: '季军大小单双',
                    help: '季军大小单双'
                }
            }
        }
    },
    //彩种类型13    幸运28
    LOTTERY_13: {
        wf_class: {

        }
    },
    //彩种类型14    重庆幸运农场
    LOTTERY_14: {
        num_min: 1,
        num_max: 20,
        num_len: 2,
        run_num_length: 8,
        wf_class: {
            kl_sf: {
                title: '幸运农场',
                row: {
                    '': ['61', '62', '63', '64', '66', '67', '65', '68', '69', '70']
                },
                '61': {//首位数投
                    type: 'select',
                    param: {titles: {yi: "首位"}, begin: 1, end: 18, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_num_count', num_separator: ',', row_separator: '-'},
                    explain: '从01至18中任选1个,投注号码与开奖号码第一位相同即中奖。',
                    example: '从01至18中任选1个,投注号码与开奖号码第一位相同即中奖。',
                    help: '从01至18中任选1个,投注号码与开奖号码第一位相同即中奖。'
                },
                '62': {//首位红投
                    type: 'select',
                    param: {'titles': {yi: "首位"}, begin: 19, end: 20, row_num_count: 10, selector: 0},
                    calculate: {method: 'formula_num_count', num_separator: ',', row_separator: '-'},
                    explain: '19，20为红号，从这两个号码任选一个投注，开奖号码第一位是红号（19或20）即中奖。',
                    example: '19，20为红号，从这两个号码任选一个投注，开奖号码第一位是红号（19或20）即中奖。',
                    help: '19，20为红号，从这两个号码任选一个投注，开奖号码第一位是红号（19或20）即中奖。'
                },
                '63': {//二连直
                    type: 'select',
                    param: {'titles': {qw: "前位", hou: '后位'}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中任选连续两位,投注号码与开奖号码任意连续两位数字、顺序均相同即中奖。',
                    example: '从20个号码中任选连续两位,投注号码与开奖号码任意连续两位数字、顺序均相同即中奖。',
                    help: '从20个号码中任选连续两位,投注号码与开奖号码任意连续两位数字、顺序均相同即中奖。'
                },
                '64': {//二连组
                    type: 'select',
                    param: {'titles': {er: "二连组"}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 2, num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中任选2个,投注号与开奖号任意连续两位数字相同(顺序不限)即中。',
                    example: '从20个号码中任选2个,投注号与开奖号任意连续两位数字相同(顺序不限)即中。',
                    help: '从20个号码中任选2个,投注号与开奖号任意连续两位数字相同(顺序不限)即中。'
                },
                '65': {//快乐二
                    type: 'select',
                    param: {'titles': {er: "快乐二"}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 2, num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中任选2个,投注号码与开奖号码任意两位相同即中奖。',
                    example: '从20个号码中任选2个,投注号码与开奖号码任意两位相同即中奖。',
                    help: '从20个号码中任选2个,投注号码与开奖号码任意两位相同即中奖。'
                },
                '66': {//前三直
                    type: 'select',
                    param: {
                        'titles': {yi: "第一位", er: "第二位", san: "第三位"},
                        begin: 1,
                        end: 20,
                        row_num_count: 10,
                        selector: 2
                    },
                    calculate: {method: 'formula_count_no_repeat', num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中猜开奖号码前三位,投注号码与开奖号码前三位数字、顺序均相同即中奖。',
                    example: '从20个号码中猜开奖号码前三位,投注号码与开奖号码前三位数字、顺序均相同即中奖。',
                    help: '从20个号码中猜开奖号码前三位,投注号码与开奖号码前三位数字、顺序均相同即中奖。'
                },
                '67': {//前三组
                    type: 'select',
                    param: {'titles': {san: "前三组"}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 3, num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中猜开奖号码的前三位,投注号与开奖号前三位数字相同(顺序不限)即中。',
                    example: '从20个号码中猜开奖号码的前三位,投注号与开奖号前三位数字相同(顺序不限)即中。',
                    help: '从20个号码中猜开奖号码的前三位,投注号与开奖号前三位数字相同(顺序不限)即中。'
                },
                '68': {//快乐三
                    type: 'select',
                    param: {'titles': {san: "快乐三"}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 3, num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中任选3个,投注号码与开奖号码任意三位相同即中奖。',
                    example: '从20个号码中任选3个,投注号码与开奖号码任意三位相同即中奖。',
                    help: '从20个号码中任选3个,投注号码与开奖号码任意三位相同即中奖。'
                },
                '69': {//快乐四
                    type: 'select',
                    param: {'titles': {si: "快乐四"}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 4, num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中任选4个,投注号码与开奖号码任意四位相同即中奖。',
                    example: '从20个号码中任选4个,投注号码与开奖号码任意四位相同即中奖。',
                    help: '从20个号码中任选4个,投注号码与开奖号码任意四位相同即中奖。'
                },
                '70': {//快乐五
                    type: 'select',
                    param: {'titles': {wu: "快乐五"}, begin: 1, end: 20, row_num_count: 10, selector: 2},
                    calculate: {method: 'formula_zx_fs', base_len: 5, num_separator: ',', row_separator: '-'},
                    explain: '从20个号码中任选5个,投注号码与开奖号码任意五位相同即中奖。',
                    example: '从20个号码中任选5个,投注号码与开奖号码任意五位相同即中奖。',
                    help: '从20个号码中任选5个,投注号码与开奖号码任意五位相同即中奖。'
                }
            }
        }
    }
};
var NUM_VALUE= {
    zhi_san: {
        '0': 1,
        '1': 3,
        '2': 6,
        '3': 10,
        '4': 15,
        '5': 21,
        '6': 28,
        '7': 36,
        '8': 45,
        '9': 55,
        '10': 63,
        '11': 69,
        '12': 73,
        '13': 75,
        '14': 75,
        '15': 73,
        '16': 69,
        '17': 63,
        '18': 55,
        '19': 45,
        '20': 36,
        '21': 28,
        '22': 21,
        '23': 15,
        '24': 10,
        '25': 6,
        '26': 3,
        '27': 1
    },
    kd_san: {
        '0': 10,
        '1': 54,
        '2': 96,
        '3': 126,
        '4': 144,
        '5': 150,
        '6': 144,
        '7': 126,
        '8': 96,
        '9': 54
    },
    zu_san: {
        '1': 1,
        '2': 2,
        '3': 2,
        '4': 4,
        '5': 5,
        '6': 6,
        '7': 8,
        '8': 10,
        '9': 11,
        '10': 13,
        '11': 14,
        '12': 14,
        '13': 15,
        '14': 15,
        '15': 14,
        '16': 14,
        '17': 13,
        '18': 11,
        '19': 10,
        '20': 8,
        '21': 6,
        '22': 5,
        '23': 4,
        '24': 2,
        '25': 2,
        '26': 1
    },
    'zhi_er': {
        '0': 1,
        '1': 2,
        '2': 3,
        '3': 4,
        '4': 5,
        '5': 6,
        '6': 7,
        '7': 8,
        '8': 9,
        '9': 10,
        '10': 9,
        '11': 8,
        '12': 7,
        '13': 6,
        '14': 5,
        '15': 4,
        '16': 3,
        '17': 2,
        '18': 1
    },
    'kd_er': {
        '0': 10,
        '1': 18,
        '2': 16,
        '3': 14,
        '4': 12,
        '5': 10,
        '6': 8,
        '7': 6,
        '8': 4,
        '9': 2
    },
    'zu_er': {
        '1': 1,
        '2': 1,
        '3': 2,
        '4': 2,
        '5': 3,
        '6': 3,
        '7': 4,
        '8': 4,
        '9': 5,
        '10': 4,
        '11': 4,
        '12': 3,
        '13': 3,
        '14': 2,
        '15': 2,
        '16': 1,
        '17': 1
    },
    'fc_spice_012': {
        '000': 64,
        '001': 48,
        '002': 48,
        '010': 48,
        '011': 36,
        '012': 36,
        '020': 48,
        '021': 36,
        '022': 36,
        '100': 48,
        '101': 36,
        '102': 36,
        '110': 36,
        '111': 27,
        '112': 27,
        '120': 27,
        '121': 36,
        '122': 27,
        '200': 48,
        '201': 36,
        '202': 36,
        '210': 36,
        '211': 27,
        '212': 27,
        '220': 36,
        '221': 27,
        '222': 27
    },
    'ks_sbt': {
        '6': 1,
        '7': 1,
        '8': 2,
        '9': 3,
        '10': 3,
        '11': 3,
        '12': 3,
        '13': 2,
        '14': 1,
        '15': 1
    }
};
var NUM_CAPTION_VALUE= {
    bjl: {
        num_cls: 'nbt',
        row_num_count: 4,
        num: {
            '庄闲': 1,
            '对子': 2,
            '豹子': 3,
            '天王': 4
        },
        sort: ['庄闲', '对子', '豹子', '天王']
    },
    tsh: {
        num_cls: 'nbt',
        row_num_count: 3,
        num: {
            '豹子': 1,
            '顺子': 2,
            '对子': 3
        },
        sort: ['豹子', '顺子', '对子']
    },
    dx_ds: {
        num_cls: 'nb',
        row_num_count: 4,
        num: {
            '大': 9,
            '小': 1,
            '单': 3,
            '双': 2
        },
        sort: ['大', '小', '单', '双']
    },
    fc_spice_012: {
        zero: {
            num_cls: 'nbt',
            row_num_count: 9,
            num: {
                '000': '000',
                '001': '001',
                '002': '002',
                '010': '010',
                '011': '011',
                '012': '012',
                '020': '020',
                '021': '021',
                '022': '022'
            },
            sort: ['000', '001', '002', '010', '011', '012', '020', '021', '022']
        },
        one: {
            num_cls: 'nbt',
            row_num_count: 9,
            num: {
                '100': '100',
                '101': '101',
                '102': '102',
                '110': '110',
                '111': '111',
                '112': '112',
                '120': '120',
                '121': '121',
                '122': '122'
            },
            sort: ['100', '101', '102', '110', '111', '112', '120', '121', '122']
        },
        two: {
            num_cls: 'nbt',
            row_num_count: 9,
            num: {
                '200': '200',
                '201': '201',
                '202': '202',
                '210': '210',
                '211': '211',
                '212': '212',
                '220': '220',
                '221': '221',
                '222': '222'
            },
            sort: ['200', '201', '202', '210', '211', '212', '220', '221', '222']
        }
    },
    fc_spice_dx: {
        small: {
            num_cls: 'nbt',
            row_num_count: 4,
            num: {
                '小小小': '000',
                '小小大': '001',
                '小大小': '010',
                '小大大': '011'
            },
            sort: ['小小小', '小小大', '小大小', '小大大']
        },
        big: {
            num_cls: 'nbt',
            row_num_count: 4,
            num: {
                '大小小': '100',
                '大小大': '101',
                '大大小': '110',
                '大大大': '111'
            },
            sort: ['大小小', '大小大', '大大小', '大大大']
        }
    },
    fc_spice_zh: {
        zhi: {
            num_cls: 'nbt',
            row_num_count: 4,
            num: {
                '质质质': '000',
                '质质合': '001',
                '质合质': '010',
                '质合合': '011'
            },
            sort: ['质质质', '质质合', '质合质', '质合合']
        },
        he: {
            num_cls: 'nbt',
            row_num_count: 4,
            num: {
                '合质质': '100',
                '合质合': '101',
                '合合质': '110',
                '合合合': '111'
            },
            sort: ['合质质', '合质合', '合合质', '合合合']
        }
    },
    fc_spice_jo: {
        ji: {
            num_cls: 'nbt',
            row_num_count: 4,
            num: {
                '奇奇奇': '111',
                '奇奇偶': '111',
                '奇偶奇': '101',
                '奇偶偶': '100'
            },
            sort: ['奇奇奇', '奇奇偶', '奇偶奇', '奇偶偶']
        },
        ou: {
            num_cls: 'nbt',
            row_num_count: 4,
            num: {
                '偶奇奇': '011',
                '偶奇偶': '010',
                '偶偶奇': '001',
                '偶偶偶': '000'
            },
            sort: ['偶奇奇', '偶奇偶', '偶偶奇', '偶偶偶']
        }
    },
    'fc_spice_dx_num': {
        num: {
            '小': '0',
            '大': '1'
        }
    },
    'fc_spice_zh_num': {
        num: {
            '质': '0',
            '合': '1'
        }
    },
    'fc_spice_jo_num': {
        num: {
            '偶': '0',
            '奇': '1'
        }
    },
    eleven_five_dds: {
        num_cls: 'nbt',
        row_num_count: 6,
        num: {
            '5单0双': '0',
            '4单1双': '1',
            '3单2双': '2',
            '2单3双': '3',
            '1单4双': '4',
            '0单5双': '5'
        },
        sort: ['5单0双', '4单1双', '3单2双', '2单3双', '1单4双', '0单5双']
    },
    lhc_dx_ds: {
        num_cls: 'nbt',
        row_num_count: 5,
        num: {
            '特大': '01',
            '特小': '02',
            '特单': '03',
            '特双': '04',
            '特和': '05'
        },
        sort: ['特大', '特小', '特单', '特双', '特和']
    },
    lhc_sx: {
        num_cls: 'nb',
        row_num_count: 12,
        num: {
            '鼠': '01',
            '牛': '02',
            '虎': '03',
            '兔': '04',
            '龙': '05',
            '蛇': '06',
            '马': '07',
            '羊': '08',
            '猴': '09',
            '鸡': '10',
            '狗': '11',
            '猪': '12'
        },
        sort: ['鼠', '牛', '虎', '兔', '龙', '蛇', '马', '羊', '猴', '鸡', '狗', '猪']
    },
    lhc_sb: {
        num_cls: 'nbt',
        row_num_count: 3,
        num: {
            '红波': '01',
            '蓝波': '02',
            '绿波': '03'
        },
        sort: ['红波', '蓝波', '绿波']
    },
    ks_dx_ds: {
        num_cls: 'nb',
        row_num_count: 4,
        num: {
            '大': 1,
            '小': 2,
            '单': 3,
            '双': 4
        },
        sort: ['大', '小', '单', '双']
    },
    ks_et_fs: {
        nbs_cls: 'nbs_dice_2',
        num_cls: 'dices',
        num: {
            '11*': {num: ['top_dice dice_0', 'dice_1', 'dice_1'], value: 1},
            '22*': {num: ['top_dice dice_0', 'dice_2', 'dice_2'], value: 2},
            '33*': {num: ['top_dice dice_0', 'dice_3', 'dice_3'], value: 3},
            '44*': {num: ['top_dice dice_0', 'dice_4', 'dice_4'], value: 4},
            '55*': {num: ['top_dice dice_0', 'dice_5', 'dice_5'], value: 5},
            '66*': {num: ['top_dice dice_0', 'dice_6', 'dice_6'], value: 6}
        },
        sort: ['11*', '22*', '33*', '44*', '55*', '66*']
    },
    ks_et_bz: {
        et: {
            nbs_cls: 'nbs_dice_1',
            num_cls: 'dices',
            num: {
                '11': {num: ['dice_1', 'dice_1'], value: 1},
                '22': {num: ['dice_2', 'dice_2'], value: 2},
                '33': {num: ['dice_3', 'dice_3'], value: 3},
                '44': {num: ['dice_4', 'dice_4'], value: 4},
                '55': {num: ['dice_5', 'dice_5'], value: 5},
                '66': {num: ['dice_6', 'dice_6'], value: 6}
            },
            sort: ['11', '22', '33', '44', '55', '66']
        },
        bt: {
            nbs_cls: 'nbs_dice_0',
            num: {
                '1': '1',
                '2': '2',
                '3': '3',
                '4': '4',
                '5': '5',
                '6': '6'
            },
            sort: ['1', '2', '3', '4', '5', '6']
        }
    },
    ks_sth: {
        nbs_cls: 'nbs_dice_2',
        num_cls: 'dices',
        num: {
            '111': {num: ['top_dice dice_1', 'dice_1', 'dice_1'], value: 1},
            '222': {num: ['top_dice dice_2', 'dice_2', 'dice_2'], value: 2},
            '333': {num: ['top_dice dice_3', 'dice_3', 'dice_3'], value: 3},
            '444': {num: ['top_dice dice_4', 'dice_4', 'dice_4'], value: 4},
            '555': {num: ['top_dice dice_5', 'dice_5', 'dice_5'], value: 5},
            '666': {num: ['top_dice dice_6', 'dice_6', 'dice_6'], value: 6}
        },
        sort: ['111', '222', '333', '444', '555', '666']
    },
    ks_slh: {
        nbs_cls: 'nbs_dice_2',
        num_cls: 'dices',
        num: {
            '123': {num: ['top_dice dice_1', 'dice_2', 'dice_3'], value: 123},
            '234': {num: ['top_dice dice_2', 'dice_3', 'dice_4'], value: 234},
            '345': {num: ['top_dice dice_3', 'dice_4', 'dice_5'], value: 345},
            '456': {num: ['top_dice dice_4', 'dice_5', 'dice_6'], value: 456}
        },
        sort: ['123', '234', '345', '456']
    },
    rx_wz: {
        num: {
            '0': '万',
            '1': '千',
            '2': '百',
            '3': '十',
            '4': '个'
        }
    },
    lucky_dxds: {
        num: {
            '大': '0',
            '小': '1',
            '单': '2',
            '双': '3'
        }
    },
    lucky_bs: {
        num: {
            '红': '0',
            '绿': '1',
            '蓝': '2'
        }
    },
    lucky_tmbs: {
        num: {'特码包三': '0'}
    },
    lucky_tszh: {
        num: {'豹子': '0'}
    },
    lucky_zh: {
        num: {
            '大单': '0',
            '小单': '1',
            '大双': '2',
            '小双': '3'
        }
    },
    lucky_jdjx: {
        num: {
            '极大': '0',
            '极小': '1'
        }
    }
};
var CAPTION_VALUE_WF= {
    '120205': 'dx_ds',
    '16': 'dx_ds',
    '130337': 'dx_ds',
    '132537': 'dx_ds',
    '150060': 'bjl',
    '220205': 'dx_ds',
    '221305': 'dx_ds',
    '230032': 'fc_spice_dx_num',
    '230033': 'fc_spice_zh_num',
    '230034': 'fc_spice_jo_num',
    '350008': 'eleven_five_dds',
    '120001': 'rx_wz',
    '120038': 'rx_wz',
    '120004': 'rx_wz',
    '120003': 'rx_wz',
    '120039': 'rx_wz',
    '130001': 'rx_wz',
    '130038': 'rx_wz',
    '130042': 'rx_wz',
    '130041': 'rx_wz',
    '130044': 'rx_wz',
    '130043': 'rx_wz',
    '130030': 'rx_wz',
    '130039': 'rx_wz',
    '140001': 'rx_wz',
    '140041': 'rx_wz',
    '140042': 'rx_wz',
    '140043': 'rx_wz',
    '140044': 'rx_wz',
    '400051': 'dx_ds',
    '400052': 'dx_ds',
    '400053': 'dx_ds',
    '500029': 'ks_dx_ds',
    '600002': 'lucky_dxds',
    '600003': 'lucky_bs',
    '600005': 'lucky_tszh',
    '600006': 'lucky_zh',
    '600007': 'lucky_jdjx'
};