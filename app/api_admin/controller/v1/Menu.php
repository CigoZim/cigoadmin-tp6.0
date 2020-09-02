<?php
declare (strict_types=1);

namespace app\api_admin\controller\v1;

use app\api_admin\controller\CommonV1;
use app\cigo_admin_core\library\traites\Tree;
use app\cigo_admin_core\model\UserMgAuthRule;

class Menu extends CommonV1
{
    use Tree;

    public function index()
    {
        $map = [
            ['module', '=', 'admin'],
            ['status', '=', 1]
        ];
        $dataList = UserMgAuthRule::where($map)
            ->order('pid asc, group_sort desc, group asc, sort desc, id asc')
            ->select();
        $treeList = [];
        if ($dataList) {
            $this->convertToTree($dataList, $treeList, 0, 'pid', true);
        }

        return $this->makeApiReturn('获取成功', $treeList);
    }
}
