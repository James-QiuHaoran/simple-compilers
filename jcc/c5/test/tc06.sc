// for, while, break, continue 
k = 1;
for(i=1; i<100; i=i+k;) {
  j=i;
  while(j > 0) {
    j = j / 2;
    if(j == 1)
      //break;
      j = -1;
  }
//  if(i<10) {
//    continue;
//  }
  k=k+1;
}

puti_(i);
puts_(", ");
puti_(j);
puts_(", ");
puti(k);

