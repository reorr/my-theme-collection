const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#181813", /* black   */
  [1] = "#38856A", /* red     */
  [2] = "#5C8F6E", /* green   */
  [3] = "#939238", /* yellow  */
  [4] = "#A29770", /* blue    */
  [5] = "#CA9C74", /* magenta */
  [6] = "#329786", /* cyan    */
  [7] = "#adc6bc", /* white   */

  /* 8 bright colors */
  [8]  = "#798a83",  /* black   */
  [9]  = "#38856A",  /* red     */
  [10] = "#5C8F6E", /* green   */
  [11] = "#939238", /* yellow  */
  [12] = "#A29770", /* blue    */
  [13] = "#CA9C74", /* magenta */
  [14] = "#329786", /* cyan    */
  [15] = "#adc6bc", /* white   */

  /* special colors */
  [256] = "#181813", /* background */
  [257] = "#adc6bc", /* foreground */
  [258] = "#adc6bc",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
