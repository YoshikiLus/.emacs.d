# -*- mode: snippet -*-
# name: pointsnip
# key: pointsnip
# --
typedef pair<int, int> point_t;
point_t operator+( point_t &lhs, point_t &rhs)
{
  point_t p = make_pair(lhs.first + rhs.first, lhs.second + rhs.second);
  return p;
}

point_t operator-( point_t &lhs, point_t &rhs)
{
  point_t p = make_pair(lhs.first - rhs.first, lhs.second - rhs.second);
  return p;
}


bool operator==(point_t &lhs, point_t &rhs)
{
  return (lhs.first == rhs.first) && (lhs.second == rhs.second);
}

bool operator!=(point_t &lhs, point_t &rhs)
{
  return (lhs.first != rhs.first) || (lhs.second != rhs.second);
}

bool is_in_field(int row, int col,  point_t &point){
  const int r = point.first;
  const int c = point.second;
  return (1<= c && c<=col) && (1 <= r && r <= row);
}
