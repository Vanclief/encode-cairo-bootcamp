// Perform and log output of simple arithmetic operations
func simple_math() {
   // adding 13 +  14
   let sum = 13 + 14;
   %{ print(f"Add {ids.sum}") %}

   // multiplying 3 * 6
   let mul = 3 * 6;
   %{ print(f"Mul {ids.mul}") %}

   // dividing 6 by 2
   let div1 = 6 / 2;
   %{ print(f"Div 1 {ids.div1}") %}

   // dividing 70 by 2
   let div2 = 70 / 2;
   %{ print(f"Div 2 {ids.div2}") %}

   // dividing 7 by 2
   let div3 = 7 / 2;
   %{ print(f"Div 3 {ids.div3}") %}

   let safe = div3 * 4;
   %{ print(f"3.5 * 4 {ids.safe}") %}

    return ();
}
