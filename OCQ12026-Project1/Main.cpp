#include "easm.h"
#include "MipsDisplay.hpp"


static MipsDisplay* display;
extern "C" ErrorCode handleSyscall(uint32_t *regs, void *mem, MemoryMap *mem_map)
{
    unsigned v0 = regs[Register::v0];
    switch (v0)
    {
        case 100: 
        if(!display)
        display=new MipsDisplay();
            display->RunEngine();
            return ErrorCode::Ok;
        default:
        return ErrorCode::SyscallNotImplemented;
    }
}
