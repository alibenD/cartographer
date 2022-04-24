/**-----------------------------------------------
  * @Copyright (C) All rights reserved.
  * @filename: DummyTest_F.cc
  * @author: aliben.develop@gmail.com
  * @created_date: 2022-04-24 23:32:44
  * @last_modified_date: NO_LAST_MODIFIED_DATE
  * @description: TODO
  *-----------------------------------------------*/

//INCLUDE
#include <lua/dummy_test.hh>
#include <gtest/gtest.h>

//CODE

using namespace Demo;

class DummyTestSuite : public testing::Test
{
  protected:
    Obj* ptr_obj_;
    virtual void SetUp() override{
      this->ptr_obj_ = new Obj();
      this->ptr_obj_->setValue(2);
    }

    virtual void TearDown() override{
      delete this->ptr_obj_;
      this->ptr_obj_ = nullptr;
    }
};

TEST_F(DummyTestSuite, ObjTestCase1)
{
  EXPECT_EQ(1, ptr_obj_->func_return1());
  EXPECT_EQ(2, ptr_obj_->func_return2());
  EXPECT_EQ(2, ptr_obj_->getValue());
  ptr_obj_->setValue(10);
  EXPECT_EQ(10, ptr_obj_->getValue());
};

TEST_F(DummyTestSuite, ObjTestCase2)
{
  EXPECT_EQ(2, ptr_obj_->getValue());
}

int main(int argc, char** argv)
{
  testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
