const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#fdf8fc", /* black   */
  [1] = "#A61C4D", /* red     */
  [2] = "#CF074C", /* green   */
  [3] = "#E1245F", /* yellow  */
  [4] = "#A74755", /* blue    */
  [5] = "#E94F6E", /* magenta */
  [6] = "#EC468E", /* cyan    */
  [7] = "#211D33", /* white   */

  /* 8 bright colors */
  [8]  = "#948090",  /* black   */
  [9]  = "#A61C4D",  /* red     */
  [10] = "#CF074C", /* green   */
  [11] = "#E1245F", /* yellow  */
  [12] = "#A74755", /* blue    */
  [13] = "#E94F6E", /* magenta */
  [14] = "#EC468E", /* cyan    */
  [15] = "#211D33", /* white   */

  /* special colors */
  [256] = "#fdf8fc", /* background */
  [257] = "#211D33", /* foreground */
  [258] = "#211D33",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
