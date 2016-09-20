unsigned int factorial(unsigned int number)
{
  if (number == 0 || number == 1)
  {
    return 1;
  }
  else
  {
    int r = number;
    while(number-- > 2)
      r *= number;
    return r;
  }
}
