#include "easm.h"
#include "MipsDisplay.hpp"


static MipsDisplay* display;
extern "C" ErrorCode handleSyscall(uint32_t *regs, void *mem, MemoryMap *mem_map)
{
    unsigned v0 = regs[Register::v0];
    unsigned a0=regs[Register::a0];
    unsigned a1=regs[Register::a1];
    unsigned a2=regs[Register::a2];
    switch (v0)
    {
        case 100: 
        if(!display)
        display=new MipsDisplay();
            display->RunEngine();
            return ErrorCode::Ok;
        case 101:
            if(display)
            display->SetPixel(a0,a1,a2);
            return ErrorCode::Ok;
        case 102:
        if(display)
            display->Flush();
            return ErrorCode::Ok;
        case 103:
        if(display)
            display->Clear(a0);
            return ErrorCode::Ok;
        case 104:
        if(display)
           regs[Register::v0]=display->GetLastKey();
        else
            regs[Register::v0]=0;
            return ErrorCode::Ok;
        case 105:
        if(display)
            display->StopEngine();
            return ErrorCode::Ok;
        default:
        return ErrorCode::SyscallNotImplemented;
    }
}
