#Carregando os pacotes
library('RPostgreSQL')
library(mailR)
library(xlsx)

rm(list=ls())

#configuração de envio
from <- "andrepignata@usp.br"
#assunto do email
subject <- "Certificado curso RWorkflow para Pesquisador"
#corpo do meil
body <- "Prezado(a), segue em anexo o certificado do curso RWorkflow para Pesquisador. 
  Espero que tenham gostado do curso!

Abraços
"                     
#carrega arquivo de inscritos
dInscritos <- read.xlsx('inscricao.xls',sheetIndex = 1)
#dInscritos <- read.csv2('Controle para Certificados - WWW.csv')
i <- 1
for(i in 1:nrow(dInscritos)) {
  #Gera certificados
  #O corpo do certificado, bem como o modelo, deve ser alterado no arquivo certificado.Rmd
  rmarkdown::render('certificado.Rmd', output_file = paste0('certificados/',gsub(' ','_',dInscritos[i,'Nome']),'.pdf'),
                   #params = params,
                   envir = new.env(parent = globalenv()))
  to <- dInscritos[i,'email']
  #ENVIANDO EMAILS
  # send.mail(from, to, subject, body,
  #           smtp = list(host.name = "smtp.usp.br", port = 587, 
  #                       user.name="XXXXXXX", passwd="XXXXXXXX"),
  #           authenticate = TRUE,
  #           send = TRUE,
  #           attach.files =paste0('certificados/',gsub(' ','_',dInscritos[i,'Nome']),'.pdf')
  #           
  # )
}










