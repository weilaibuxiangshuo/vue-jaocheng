<template>
  <div class="app-container">
    <div>
      <el-button type="primary" @click="addUser" isbtnpermission="add" v-has>添加用户</el-button>
      <span>
        <el-button icon="el-icon-search" circle @click="searchBtnData"></el-button>
      </span>
      <span class="spanStyleCss">
        <el-input class="inputStyleSearch" v-model="search" size="mini" placeholder="输入用户名称搜索" />
      </span>
    </div>
    <el-dialog
      :title="isShowDialog==='edit'?'编辑用户':'添加用户'"
      :visible.sync="dialogFormVisible"
      :width="defaultWidth"
      :before-close="closeDialog"
    >
      <el-form :model="form" :rules="rules" ref="ruleForm">
        <el-form-item label="用户名称" :label-width="formLabelWidth" prop="username">
          <el-input v-model="form.username" placeholder="名称必须填写" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="用户密码" :label-width="formLabelWidth" prop="password">
          <el-input v-model="form.password" placeholder="密码不能为空" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="所属角色" :label-width="formLabelWidth" prop="roles">
          <el-select v-model="form.roles" placeholder="请选择所属角色">
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
      <el-table-column label="用户名称" prop="title"></el-table-column>
      <el-table-column label="所属角色" prop="role"></el-table-column>
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
  username: "",
  password: "",
  roles: ""
};

const defaultTableData = [
  {
    id: "",
    title: "",
    roleId: "",
    role: ""
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
    var validateRoles=(rule,value,callback)=>{
      if(value===""){
        callback(new Error("请选择所属角色"))
      }else{
        callback()
      }
    }
    return {
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
        username: [
          { required: true, message: "请输入用户名称", trigger: "blur" },
          { min: 5, max: 18, message: "长度在 5 到 18 位字符", trigger: "blur" }
        ],
        password:[
          { required: true, message: "请输入密码", trigger: "blur" },
          { min: 6, max: 12, message: "长度在 6 到 12 位字符", trigger: "blur" }
        ],
        roles:[
          {required: true,validator: validateRoles, trigger: 'blur' }
        ]
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
      const tempData = {
        username: row.title,
        password: "",
        roles: row.roleId
      };
      this.form = tempData;
    },
    //删除当前行
    handleDelete(index, row) {
      let idList = [];
      idList.push(row.id);
      this.$store.dispatch("persons/delRoleList", idList).then(response => {
        this.paginationData.total -= 1;
        this.getRole();
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
        this.$store.dispatch("persons/delRoleList", idList).then(response => {
          this.getRole();
        });
      } else {
        return false;
      }
    },
    //获取checkbox中选中的行值
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    //条数改变
    handleSizeChange(val) {
      this.paginationData.size = val;
      this.getRole();
    },
    //页面改变
    handleCurrentChange(val) {
      this.paginationData.page = val;
      this.getRole();
    },
    //表格中"操作"居中
    oneCellStyle({ row, column, rowIndex, columnIndex }) {
      if (rowIndex === 0 && columnIndex === 6) {
        return { "text-align": "right", "padding-right": "61px" };
      }
    },
    //表格全选
    toggleSelectionAll() {
      this.$refs.multipleTable.toggleAllSelection();
    },
    //添加角色
    addUser() {
      this.form = Object.assign({}, defaultDialogForm);
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
        //加密密码;
        let newPassword = this.form.password.trim();
        if (newPassword !== "") {
          let sha256 = require("js-sha256").sha256;
          newPassword = sha256(this.form.password);
        }
        let data = JSON.stringify({
          username: this.form.username,
          password: newPassword,
          roles: this.form.roles
        });
        let newdata = new FormData();
        newdata.append("data", data);
        this.$store.dispatch("persons/addRoleList", newdata).then(response => {
          if (this.isShowDialog !== "edit") {
            this.paginationData.total += 1;
          }
          this.getRole();
        });
      }
    },
    //获取菜单所有数据
    getRole(getall = "") {
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
        .dispatch("persons/getRoleData", paginationList)
        .then(response => {
          this.formSelectList = response.role;
          this.tableData = response.users;
          this.paginationData.total = response.total;
        });
    },
    //搜索数据
    searchBtnData() {
      let oneData = {};
      const searchData = this.search.trim();
      oneData["search"] = searchData;
      this.getRole(oneData);
      this.search = "";
    }
  },
  created() {
    this.getRole();
  }
};
</script>

<style scoped>
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