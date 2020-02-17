<template>
  <div class="app-container">
    <div>
      <el-button type="primary" @click="addMenu" isbtnpermission="add" v-has>添加菜单</el-button>
      <span>
        <el-button icon="el-icon-search" circle @click="searchBtnData"></el-button>
      </span>
      <span class="spanStyleCss">
        <el-input class="inputStyleSearch" v-model="search" size="mini" placeholder="输入菜单名称搜索" />
      </span>
    </div>
    <el-dialog
      :title="isShowDialog==='edit'?'编辑菜单':'添加菜单'"
      :visible.sync="dialogFormVisible"
      :width="defaultWidth"
      :before-close="closeDialog"
    >
      <el-form :model="form" :rules="rules" ref="ruleForm">
        <el-form-item label="菜单名称" :label-width="formLabelWidth" prop="name">
          <el-input v-model="form.name" placeholder="名称必须填写" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="菜单路径" :label-width="formLabelWidth" prop="path">
          <el-input v-model="form.path" placeholder="格式：/ + 地址(例：/example)" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="菜单图标" :label-width="formLabelWidth" prop="icon">
          <el-input v-model="form.icon" placeholder="父类必须填写图标" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="菜单顺序" :label-width="formLabelWidth" prop="order">
          <el-input v-model="form.order" placeholder="数值越小越靠前" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="上级菜单" :label-width="formLabelWidth" prop="parent">
          <el-select v-model="form.parent" placeholder="请选择活动区域">
            <el-option label="父类菜单" :value="parentValue"></el-option>
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
      <el-table-column label="菜单名称" prop="title"></el-table-column>
      <el-table-column label="菜单图标" prop="icon">
        <template slot-scope="scope">
          <p>{{scope.row.icon | filterIcon}}</p>
        </template>
      </el-table-column>

      <el-table-column label="菜单顺序" prop="order"></el-table-column>
      <el-table-column label="上级菜单" prop="parent">
        <template slot-scope="scope">
          <p>{{scope.row.parent | filterParent}}</p>
        </template>
      </el-table-column>
      <el-table-column label="链接地址" prop="path" width="300"></el-table-column>
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
  icon: "",
  order: "",
  parent: ""
};

const defaultTableData = [
  {
    name: "",
    path: "",
    icon: "",
    order: "",
    parent: ""
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
    var valiOrder = (rule, value, callback) => {
      let newValue = value.trim();
      let isReg = new RegExp("[0-9]+");
      if (newValue === "") {
        callback(new Error("请输入数字"));
      } else if (!isReg.test(newValue)) {
        callback(new Error("格式不正确"));
      } else {
        callback();
      }
    };
    var valiParent = (rule, value, callback) => {
      if (value === "" || value === null) {
        callback(new Error("请选择上级菜单"));
      } else {
        callback();
      }
    };
    return {
      isShowDialog: "new",
      tableData: Object.assign([], defaultTableData),
      search: "",
      currentPage4: 4,
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
        order: [{ trigger: "blur", required: true, validator: valiOrder }],
        parent: [{ trigger: "blur", required: true, validator: valiParent }]
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
      let temp1 = null;
      if (row.parentId === "") {
        temp1 = "0";
      } else {
        temp1 = row.parentId;
      }
      const tempData = {
        name: row.title,
        path: row.path,
        icon: row.icon,
        order: row.order,
        parent: temp1
      };
      this.form = tempData;
      let oneForm = {};
      oneForm["getall"] = 111;
      this.getMenu(oneForm);
    },
    //删除当前行
    handleDelete(index, row) {
      let idList = [];
      idList.push(row.id);
      this.$store.dispatch("menus/delMenuList", idList).then(response => {
        this.paginationData.total -= 1;
        this.getMenu();
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
        this.$store.dispatch("menus/delMenuList", idList).then(response => {
          this.getMenu();
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
      this.getMenu();
    },
    //页面改变
    handleCurrentChange(val) {
      this.paginationData.page = val;
      this.getMenu();
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
    //添加菜单
    addMenu() {
      this.form = Object.assign({}, defaultDialogForm);
      this.dialogFormVisible = true;
      let oneForm = new FormData();
      oneForm["getall"] = 111;
      this.getMenu(oneForm);
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
          icon: this.form.icon,
          order: this.form.order,
          parent: this.form.parent
        });
        let newdata = new FormData();
        newdata.append("data", data);
        this.$store.dispatch("menus/addMenuList", newdata).then(response => {
          if (this.isShowDialog !== "edit") {
            this.paginationData.total += 1;
          }
          this.getMenu();
        });
      }
    },
    //获取菜单所有数据
    getMenu(getall = "") {
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
        .dispatch("menus/getMenuList", paginationList)
        .then(response => {
          //获取上级菜单所有数据
          if (response.alldata) {
            this.formSelectList = response.alldata.data;
          }
          this.tableData = response.data;
          this.paginationData.total = response.total;
        });
    },
    //搜索数据
    searchBtnData() {
      let oneData = {};
      const searchData = this.search.trim();
      oneData["search"] = searchData;
      this.getMenu(oneData);
      this.search = "";
    }
  },
  created() {
    this.getMenu();
  },
  filters: {
    filterParent(data) {
      let netData = data.trim();
      if (netData === "") {
        return "父类菜单";
      } else {
        return netData;
      }
    },
    filterIcon(data) {
      let netData = data.trim();
      if (netData === "") {
        return "---";
      } else {
        return netData;
      }
    }
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