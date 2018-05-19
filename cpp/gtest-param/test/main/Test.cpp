#include <gtest/gtest.h>

int actualVal = 2 + 2;
int expectVal = 4;

TEST(IntCompare, IntEqual) {
  EXPECT_EQ(expectVal, actualVal);
}

int main(int argc, char** argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
