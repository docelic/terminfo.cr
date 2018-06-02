- [ ] parser spec
- [ ] compile a database (could help for the specs)
- [ ] extended storage format



### EXTENDED STORAGE FORMAT

> From https://www.systutorials.com/docs/linux/man/5-term/

The previous section describes the conventional terminfo binary format. With some minor variations of the offsets (see PORTABILITY), the same binary format is used in all modern UNIX systems. Each system uses a predefined set of boolean, number or string capabilities.
The ncurses libraries and applications support extended terminfo binary format, allowing users to define capabilities which are loaded at runtime. This extension is made possible by using the fact that the other implementations stop reading the terminfo data when they have reached the end of the size given in the header. ncurses checks the size, and if it exceeds that due to the predefined data, continues to parse according to its own scheme.

First, it reads the extended header (5 short integers):

- (1) count of extended boolean capabilities
- (2) count of extended numeric capabilities
- (3) count of extended string capabilities
- (4) size of the extended string table in bytes.
- (5) last offset of the extended string table in bytes.

Using the counts and sizes, ncurses allocates arrays and reads data for the extended capabilities in the same order as the header information.

The extended string table contains values for string capabilities. After the end of these values, it contains the names for each of the extended capabilities in order, e.g., booleans, then numbers and finally strings.
