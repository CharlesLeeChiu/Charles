OUTPUT_ARCH(powerpc)
SECTIONS
{
  .text :
  {
    arch/powerpc/cpu/mpc83xx/start.o (.text*)
    *(.text*)
    . = ALIGN(16);
    *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
  }
  . = (. + 0x0FFF) & 0xFFFFF000;
  _erotext = .;
  PROVIDE (erotext = .);
  .reloc :
  {
    _GOT2_TABLE_ = .;
    KEEP(*(.got2))
    KEEP(*(.got))
    PROVIDE(_GLOBAL_OFFSET_TABLE_ = . + 4);
    _FIXUP_TABLE_ = .;
    KEEP(*(.fixup))
  }
  __got2_entries = ((_GLOBAL_OFFSET_TABLE_ - _GOT2_TABLE_) >> 2) - 1;
  __fixup_entries = (. - _FIXUP_TABLE_) >> 2;
  .data :
  {
    *(.data*)
    *(.sdata*)
  }
  _edata = .;
  PROVIDE (edata = .);
  . = .;
  __u_boot_cmd_start = .;
  .u_boot_cmd : { *(.u_boot_cmd) }
  __u_boot_cmd_end = .;
  . = .;
  __start___ex_table = .;
  __ex_table : { *(__ex_table) }
  __stop___ex_table = .;
  . = ALIGN(4096);
  __init_begin = .;
  .text.init : { *(.text.init) }
  .data.init : { *(.data.init) }
  . = ALIGN(4096);
  __init_end = .;
  __bss_start = .;
  .bss (NOLOAD) :
  {
   *(.bss*)
   *(.sbss*)
   *(COMMON)
   . = ALIGN(4);
  }
  __bss_end__ = . ;
  PROVIDE (end = .);
}
ENTRY(_start)
