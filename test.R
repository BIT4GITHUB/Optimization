for(i in 1:200){
  if(0.61803^i<=0.2){
    print(i);
    break;
  }
}
optimize(f,c(1,2))
