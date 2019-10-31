# Top_of_Pile
This routine finds the color of the part on top of an arbitrary pile.

    This project explores a programming problem that arises in many different robotics
applications. In a manufacturing setting, a robotic arm may need to pick up parts from a pile and
use them to assemble something such as an automobile. To plan the robotic arm’s movements,
an overhead camera may be positioned over a pile of parts. In this assignment, we will focus on
determining which color part is on top of the pile. (This may be important in finding a particular
component and uncovering it so it can be used.) We would like this task to be performed in real-
time, so the computational and storage requirements must be kept to a minimum. We are also
concerned with the functional correctness of the algorithms used (i.e., getting the correct answer),
since picking the wrong top part could lead to extra work for the robot or worse a malfunction if 
the pieces get tangled.

    Consider a pile composed of seven parts viewed from above on a 64x64 image array of cells; 
each cell is one of eight colors (black=0, pink=1, red=2, green=3, blue=4, orange=5, yellow=6, skyblue=7). 
Each part has a unique color. There will be exactly one part that is on
top of the pile. All other parts will be overlapping at least one part.

    Each part is composed of horizontal and vertical lines all of the same color. Not all parts have
the same number of horizontal or vertical lines. All horizontal lines in a part have the same
length which ranges from 25 to 45 pixels. Similarly, all vertical lines in a part have the same
length in the same range. A part’s horizontal line length is not necessarily the same as its vertical
line length. No parallel lines are adjacent to any other lines in the same part or in other parts.
Each row (column) has at most one horizontal (vertical) line. No horizontal lines occlude
(overlap) any other horizontal lines (i.e., no part will overlap another part along the same horizontal
line). Similarly, no vertical lines occlude any other vertical lines. If a row contains a horizontal
line, the row immediately above and the row immediately below that row will not contain any
horizontal lines. Similarly, the columns immediately to the right and left of a column that 
contains a vertical line will not contain any vertical lines. Lines only touch at orthogonal intersections. 
No lines touch the image boundaries.


    The image array is provided as input to the program as a linearized array of the cells in row-column order. 
The first element of the array represents the color of the first cell in the first row. This
is followed by the second cell in that row, etc. The last cell of the first row is followed by the
first cell of the second row. This way of linearizing a two dimensional array is called 
row-column mapping. The color code (0-7) is packed in an unsigned byte integer for each cell.
