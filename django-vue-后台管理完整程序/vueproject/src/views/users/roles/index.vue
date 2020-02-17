<template>
  <div class="app-container">
    <div>
      <el-button type="primary" @click="addMenu" isbtnpermission="add" v-has>角色管理</el-button>
      <span>
        <el-button icon="el-icon-search" circle @click="searchBtnData"></el-button>
      </span>
      <span class="spanStyleCss">
        <el-input class="inputStyleSearch" v-model="search" size="mini" placeholder="输入角色名称搜索" />
      </span>
    </div>
    <el-dialog
      :title="isShowDialog==='edit'?'编辑角色':'添加角色'"
      :visible.sync="dialogFormVisible"
      :width="defaultWidth"
      :before-close="closeDialog"
    >
      <el-form :model="form" :rules="rules" ref="ruleForm">
        <el-form-item label="角色名称" :label-width="formLabelWidth" prop="name">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="权限选择" :label-width="formLabelWidth">
          <el-tree
            :data="treedata"
            show-checkbox
            node-key="id"
            ref="tree"
            highlight-current
            :props="form.defaultProps"
          ></el-tree>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="handleClose">取 消</el-button>
        <el-button type="primary" @click="confirm('ruleForm')">确 定</el-button>
      </div>
    </el-dialog>
    <el-table
      :data="tableData"
      ref="multipleTable"
      tooltip-effect="dark"
      style="width: 100%"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column label="ID" type="index" width="70"></el-table-column>
      <el-table-column label="角色名称" prop="name" width="200"></el-table-column>
      <el-table-column label="关联权限" prop="option">
        <template slot-scope="scope">
          <p>{{scope.row.option | optionDataFilter}}</p>
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="180px" class="optionStyleCss">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)" isbtnpermission="add" v-has>编辑</el-button>
          <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)" isbtnpermission="delete" v-has>删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="btnConfirmStyle">
      <div>
        <el-button type="success" @click="toggleSelectionAll()">全选</el-button>
      </div>
      <div>
        <el-button type="danger" @click="handleDeleteAll" isbtnpermission="delete" v-has>删除</el-button>
      </div>
      <div class="block">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="paginationData.page"
          :page-sizes="paginationData.pagesizes"
          :page-size="paginationData.size"
          layout="total, sizes, prev, pager, next, jumper"
          :total="paginationData.total"
        ></el-pagination>
      </div>
    </div>
  </div>
</template>

<script>
import { deepCopyData } from "@/utils/users";

const defaultDialogForm = {
  name: "",
  defaultProps: {
    children: "children",
    label: "label"
  }
};

const defaulttreedata = [];

const defaultTableData = [
  {
    name: "",
    option: ""
  }
];

const defaultPagination = {
  currentpage: 1,
  page: 1,
  size: 10,
  total: 100,
  pagesizes: [10, 30, 50, 100]
};

export default {
  data() {
    return {
      treedata: Object.assign([], defaulttreedata),
      radio: "1",
      isShowDialog: "new",
      tableData: Object.assign([], defaultTableData),
      search: "",
      form: Object.assign({}, defaultDialogForm),
      dialogFormVisible: false,
      formLabelWidth: "80px",
      defaultWidth: "450px",
      parentValue: "0",
      formSelectList: "",
      paginationData: Object.assign({}, defaultPagination),
      deepDataPush: Object.assign([], defaulttreedata),
      rules: {
        name: [
          { required: true, message: "请输入角色名称", trigger: "blur" },
          { min: 5, max: 18, message: "长度在 5 到 18 位字符", trigger: "blur" }
        ]
      }
    };
  },
  methods: {
    //编辑当前行
    handleEdit(index, row) {
      this.isShowDialog = "edit";
      this.dialogFormVisible = true;
      let checkDataList = [];
      let deepData = row.option;
      this.form.name = row.name;
      if (deepData.length > 0) {
        for (let m of deepData) {
          checkDataList.push(m.id);
        }
        this.$nextTick(() => {
          this.$refs.tree.setCheckedKeys(checkDataList);
        });
      }
    },
    //删除当前行
    handleDelete(index, row) {
      let idList = [];
      idList.push(row.id);
      this.$store.dispatch("roles/delRoleList", idList).then(response => {
        this.paginationData.total -= 1;
        this.getRoles();
      });
    },
    //获取当前所有选中值
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    //删除当前页
    handleDeleteAll() {
      if (this.multipleSelection) {
        let idList = [];
        for (let tt of this.multipleSelection) {
          idList.push(tt.id);
          this.paginationData.total -= 1;
        }
        this.$store.dispatch("roles/delRoleList", idList).then(response => {
          this.getRoles();
        });
      } else {
        return false;
      }
    },
    //条数改变
    handleSizeChange(val) {
      this.paginationData.size = val;
      this.getRoles();
    },
    //页面改变
    handleCurrentChange(val) {
      this.paginationData.page = val;
      this.getRoles();
    },

    //表格全选
    toggleSelectionAll() {
      this.$refs.multipleTable.toggleAllSelection();
    },
    //添加菜单
    addMenu() {
      this.form = Object.assign({}, defaultDialogForm);
      this.isShowDialog = "new";
      this.dialogFormVisible = true;
    },
    //确定送出
    confirm(ruleForm) {
      let isConfirm = 0;
      this.$refs[ruleForm].validate(valid => {
        if (valid) {
          this.dialogFormVisible = false;
          isConfirm = 1;
        } else {
          return false;
        }
      });
      if (isConfirm === 1) {
        let mm = this.$refs.tree.getCheckedKeys();
        let tempFormData = JSON.stringify({
          name: this.form.name,
          optiondata: this.$refs.tree.getCheckedKeys()
        });
        let roleFormData = new FormData();
        roleFormData.append("data", tempFormData);
        this.$store.dispatch("roles/addRoleList", roleFormData).then(() => {
          if (this.isShowDialog !== "edit") {
            this.paginationData.total += 1;
          }
          this.resetChecks();
          this.getRoles();
        });
      }
    },
    //搜索数据
    searchBtnData() {
      let oneData = {};
      const searchData = this.search.trim();
      oneData["search"] = searchData;
      this.getRoles(oneData);
      this.search = "";
    },
    //清空树选择
    resetChecks() {
      this.$refs.tree.setCheckedKeys([]);
    },
    //关闭对话框
    closeDialog(done) {
      this.dialogFormVisible = false;
       this.resetChecks();
      this.$nextTick(() => {
        this.$refs["ruleForm"].resetFields();
      });
    },
    //对话框关闭前的清空树选择
    // :before-close="handleClose"
    handleClose() {
      this.dialogFormVisible = false;
      this.resetChecks();
      this.$refs["ruleForm"].resetFields();
    },
    //获取数据
    getRoles(getall = "") {
      //判断是否与总数相同，相同自动返回上一页
      if (
        (this.paginationData.page - 1) * this.paginationData.size ===
        this.paginationData.total
      ) {
        this.paginationData.page -= 1;
      }
      let paginationList = {
        page: JSON.parse(this.paginationData.page),
        size: JSON.parse(this.paginationData.size)
      };
      if (getall !== "") {
        paginationList["showdata"] = getall;
      }
      this.$store
        .dispatch("roles/getRoleALL", paginationList)
        .then(response => {
          this.treedata = deepCopyData(response.data);
          this.tableData = deepCopyData(response.role);
          this.paginationData.total = response.roletotal;
        });
    }
  },
  //过滤行数据
  filters: {
    optionDataFilter(data) {
      let strData = "";
      if (data.length > 0) {
        for (let tt of data) {
          strData = strData + tt.label + " | ";
        }
      }
      return strData;
    }
  },
  created() {
    //初始化数据
    this.getRoles();
  }
};
</script>

<style scoped>
.el-tree.el-tree--highlight-current {
  padding-top: 6px;
}

.radioStyleCss label {
  width: 45px;
}
.el-select /deep/ div {
  width: 330px;
}
.app-container span {
  float: right;
}

.app-container span.spanStyleCss {
  width: 30%;
  padding-right: 10px;
}
.inputStyleSearch /deep/ input {
  height: 40px;
}
.btnConfirmStyle {
  padding-top: 10px;
}
.btnConfirmStyle div {
  display: inline-block;
}
.btnConfirmStyle button.el-button.el-button {
  line-height: 6px;
}
.block {
  display: inline-block;
  line-height: 28px;
}
</style>