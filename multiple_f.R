concp <- ggplot(data.frame(x=c(0,24)), aes(x))

Simul = 1:50

cols <- brewer.pal(length(50), "Set1")
for (i in 1:50){
    concp <- concp +  stat_function(fun=function(x) x+Simul[i], geom="line")
}

concp

Subject <- seq(1, 50, length.out = 50) # 
Time <- seq(0, 24, length.out = 100) # 

d1 <- expand.grid(x = Subject, y = Time) %>% select(Subject=x, Time=y) %>% arrange(Subject)
d1 %>% mutate(Row = row_number())
d2 <- data.frame(Subject = 1:50, Var1 = rnorm(50, mean = 10, sd = 10),
                 Var2 = rnorm(50, mean = 50, sd = 100))
d12 <- left_join(d1, d2, by = "Subject") %>% mutate(Calc = Var1 * Time^2 - Var2 * sign(Time))
ggplot(d12, aes(x=Time, y=Calc, group=Subject)) + geom_line()
?rnorm
