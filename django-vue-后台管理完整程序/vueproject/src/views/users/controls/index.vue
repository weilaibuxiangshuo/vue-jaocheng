<template>
  <div class="app-container">
    <div>
      <el-button type="primary" @click="addMenu" isbtnpermission="add" v-has>权限管理</el-button>
      <span>
        <el-button icon="el-icon-search" circle @click="searchBtnData"></el-button>
      </span>
      <span class="spanStyleCss">
        <el-input class="inputStyleSearch" v-model="search" size="mini" placeholder="输入权限名称搜索" />
      </span>
    </div>
    <el-dialog
      :title="isShowDialog==='edit'?'编辑权限':'添加权限'"
      :visible.sync="dialogFormVisible"
      :width="defaultWidth"
      :before-close="closeDialog"
    >
      <el-form :model="form" :rules="rules" ref="ruleForm">
        <el-form-item label="权限名称" :label-width="formLabelWidth" prop="name">
          <el-input v-model="form.name" placeholder="名称必须填写" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="权限路径" :label-width="formLabelWidth" prop="path">
          <el-input v-model="form.path" placeholder="格式：/ + 地址(例：/example)" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item
          label="请求方式"
          :label-width="formLabelWidth"
          class="radioStyleCss"
          prop="method"
        >
          <el-radio-group v-model="form.method">
            <el-radio v-model="radio" label="GET">GET</el-radio>
            <el-radio v-model="radio" label="POST">POST</el-radio>
            <el-radio v-model="radio" label="PUT">PUT</el-radio>
            <el-radio v-model="radio" label="DELETE">DELETE</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="菜单关联" :label-width="formLabelWidth" prop="menu">
          <el-select v-model="form.menu" placeholder="请选择活动区域">
            <!-- <el-option label="父类菜单" :value="parentValue"></el-option> -->
            <el-option
              :label="line.title"
              :key="index"
              v-for="(line,index) in formSelectList"
              :value="line.id"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="handleClose('ruleForm')">取 消</el-button>
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
      <el-table-column label="权限名称" prop="title"></el-table-column>
      <el-table-column label="请求方式" prop="method"></el-table-column>
      <el-table-column label="关联菜单" prop="menu"></el-table-column>
      <el-table-column label="权限地址" prop="path" width="300px"></el-table-column>
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
import { compile } from "path-to-regexp";
const defaultDialogForm = {
  name: "",
  path: "",
  method: "GET",
  menu: ""
};

const defaultTableData = [
  {
    name: "",
    path: "",
    method: "",
    menu: ""
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
    var valiPath = (rule, value, callback) => {
      let newValue = value.substring(0, 1);
      if (value === "") {
        return callback(new Error("请输入路径"));
      } else if (newValue !== "/") {
        return callback(new Error("格式不正确"));
      } else {
        callback();
      }
    };
    var valiMenu = (rule, value, callback) => {
      if (value === "") {
        return callback(new Error("请选择关联菜单"));
      } else {
        callback();
      }
    };
    return {
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
      rules: {
        name: [
          { required: true, message: "请输入权限名称", trigger: "blur" },
          { min: 5, max: 18, message: "长度在 5 到 18 位字符", trigger: "blur" }
        ],
        path: [{ trigger: "blur", required: true, validator: valiPath }],
        menu: [{ trigger: "blur", required: true, validator: valiMenu }]
      }
    };
  },
  methods: {
    //关闭对话框
    closeDialog(done) {
      this.dialogFormVisible = false;
      this.$nextTick(() => {
        this.$refs["ruleForm"].resetFields();
      });
    },
    //取消
    handleClose(ruleForm) {
      this.dialogFormVisible = false;
      this.$refs[ruleForm].resetFields();
    },
    //编辑当前行
    handleEdit(index, row) {
      this.isShowDialog = "edit";
      this.dialogFormVisible = true;
      this.form = Object.assign({}, defaultDialogForm);
      const resData = this.$store.getters.getControlAllData.menudata;
      let rowMenu = null;
      for (let temp of resData) {
        if (row.menu === temp.title) {
          rowMenu = JSON.parse(temp.id);
        }
      }
      const tempData = {
        name: row.title,
        path: row.path,
        method: row.method,
        menu: rowMenu
      };
      this.form = tempData;
    },
    //删除当前行
    handleDelete(index, row) {
      let idList = [];
      idList.push(row.id);
      this.$store.dispatch("controls/delCtrolList", idList).then(response => {
        this.paginationData.total -= 1;
        this.getOptions();
      });
    },
    //删除当前页
    handleDeleteAll() {
      if (this.multipleSelection) {
        let idList = [];
        for (let tt of this.multipleSelection) {
          idList.push(tt.id);
          this.paginationData.total -= 1;
        }
        this.$store.dispatch("controls/delCtrolList", idList).then(response => {
          this.getOptions();
        });
      } else {
        return false;
      }
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    //条数改变
    handleSizeChange(val) {
      this.paginationData.size = val;
      this.getOptions();
    },
    //页面改变
    handleCurrentChange(val) {
      this.paginationData.page = val;
      this.getOptions();
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
        let data = JSON.stringify({
          name: this.form.name,
          path: this.form.path,
          method: this.form.method,
          menu: this.form.menu
        });
        let newdata = new FormData();
        newdata.append("data", data);
        this.$store
          .dispatch("controls/addCtrolList", newdata)
          .then(response => {
            if (this.isShowDialog !== "edit") {
              this.paginationData.total += 1;
            }
            this.getOptions();
          });
      }
    },
    //获取菜单所有数据
    getOptions(getall = "") {
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
        .dispatch("controls/getContrlALL", paginationList)
        .then(response => {
          this.formSelectList = response.menudata;
          this.tableData = response.optiondata;
          this.paginationData.total = response.total;
        });
    },
    //搜索数据
    searchBtnData() {
      let oneData = {};
      const searchData = this.search.trim();
      oneData["search"] = searchData;
      this.getOptions(oneData);
      this.search = "";
    }
  },
  created() {
    this.getOptions();
  }
};
</script>

<style scoped>
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