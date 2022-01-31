ENTRY(loader)

SECTIONS
{
	. = 1M;

	.text :
	{
		*(.multiboot)
		*(.text)
	}
	
	/DISCARD/ : { *(.comment) }
}