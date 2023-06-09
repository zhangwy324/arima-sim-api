library(plumber)
library(astsa)

#* Echo the parameter that was sent in
#* @param numbers The numbers to echo back.
#* @get /test
function(numbers){
  return (list(numbers = numbers))
}


#* Sarima simulator
#* @post /sarima
function(req){
  body = req$body
  ar = body$ar
  ma = body$ma
  d = body$d
  sar = body$sar
  sma = body$sma
  D = body$D
  S = body$S
  n = body$n    # length of the series
  seed = body$seed
  burnin = body$burnin
  if(is.null(d)){
    d = 0
  }
  if(is.null(D)){
    D = 0
  }
  if(is.null(burnin)){
    burnin = 50
  }
  if(is.null(n)){
    n = 100
  }
  set.seed(seed)
  
  tryCatch(
    expr = {
      ts = sarima.sim(ar = ar, ma = ma, d = d, sar = sar, sma = sma, D = D, S = S, n = n, burnin = burnin)
      list(data = as.numeric(ts), mean=mean(ts), var=var(ts))
    },
    error = function(err){ 
      list(error = err$message)
    }
  )
  
  # ts = sarima.sim(ar = ar, ma = ma, d = d, sar = sar, sma = sma, D = D, S = S, n = n, burnin = burnin)
  # list(data = as.numeric(ts), mean=mean(ts), var=var(ts))
}



