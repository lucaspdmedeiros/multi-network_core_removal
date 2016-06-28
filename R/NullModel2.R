# Null model 2 (Bascompte et al. 2003)
# Script by M. M. Pires, modified by Lucas Medeiros
# Creates R theoretical matrices according to null model 2.
# If write = TRUE, creates a new directory in the workspace and save the matrices.

null2_s=function(mat=A, mat.name, write=TRUE, R=100){
  
  m=dim(mat)[1] # number of rows
  n=dim(mat)[2] # number of columns
  
  rmarg=apply(mat,1,sum) # degrees of row species
  cmarg=apply(mat,2,sum) # degrees of column species
  
  #--------------------------------------------------
  #Generating a matrix with probablities for each cell
  #--------------------------------------------------
  
  prob=matrix(0,m,n)
  for (i in 1:m){
    for (j in 1:n){
      prob[i,j]=((rmarg[i]/n)+(cmarg[j]/m))/2
    }
  }  
  
  #----------------------------
  #Filling theoretical matrices
  #----------------------------
  
  mat.t=list() #To store theoretical matrices
  s=1
  
  while (s<=R){
    
    rand=matrix(runif(m*n),m,n) # matrix with numbers from a uniform distribution between 0 and 1
    aux=matrix(0, nrow=m, ncol=n) #Just to avoid indexing problems
    aux[which(rand<prob)]=1 #Filling empty matrix
    
    #--------------------------------
    #Node degrees
    #--------------------------------
    k_row = apply(aux,1,sum)
    k_col = apply(aux,2,sum)
    k = c(k_row,k_col)
    
    #-----------------
    #Storing matrices
    #-----------------
    
    if ((all(k!=0)) & (sum(aux)==sum(mat))){ #Whenever the resulting matrix has a different number of interactions or zeroed rows or columns, the code runs again
      mat.t[[s]]=aux	#store the matrix within the array
      s=s+1
    }
  }	
  
  #-----------------
  #Saving matrices
  #-----------------
  
  if (write==TRUE) {
    curr.dir = getwd()
    new.dir = paste(mat.name, "Null", sep="_")
    full.dir = paste(curr.dir, new.dir, sep="/")
    dir.create(full.dir)
    for(i in 1:R){
      name=paste(new.dir, "_", i,".txt", sep="")
      write.table(mat.t[[i]],file=paste(full.dir, name, sep="/"),row.names=F, col.names=F, append=T, quote=F)  
    }	
  }
  
  return(mat.t)
  
}