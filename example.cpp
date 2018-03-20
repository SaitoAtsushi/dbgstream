// -*- mode: c++ -*-

#include "dbgstream.h"
using namespace std;

int main(void) {
  cdbg << "1+1=" << 1+1 << endl;
  cdbg << "100=0x" << hex << 100 << endl;
  return 0;
}
