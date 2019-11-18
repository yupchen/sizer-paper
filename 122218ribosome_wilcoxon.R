setwd('C:/Users/cyp7c_000/Dropbox/Zuoye/Futcher_Lab/SizerPaper/Figures/122018/SFigure_ribosome')
A <- data.matrix(read.csv('g.txt'))
B <- data.matrix(read.csv('gr.txt'))
wilcox.test(A, B, paired = FALSE, alternative = "two.sided", mu = 0.0,exact = FALSE, correct = TRUE, conf.int = TRUE, conf.level = 0.95)

A <- data.matrix(read.csv('elute1.txt'))
B <- data.matrix(read.csv('elute1r.txt'))
wilcox.test(A, B, paired = FALSE, alternative = "two.sided", mu = 0.0,exact = FALSE, correct = TRUE, conf.int = TRUE, conf.level = 0.95)

A <- data.matrix(read.csv('elute2.txt'))
B <- data.matrix(read.csv('elute2r.txt'))
wilcox.test(A, B, paired = FALSE, alternative = "two.sided", mu = 0.0,exact = FALSE, correct = TRUE, conf.int = TRUE, conf.level = 0.95)

A <- data.matrix(read.csv('elutecontrol.txt'))
B <- data.matrix(read.csv('elutecontrolr.txt'))
wilcox.test(A, B, paired = FALSE, alternative = "two.sided", mu = 0.0,exact = FALSE, correct = TRUE, conf.int = TRUE, conf.level = 0.95)

A <- data.matrix(read.csv('inhibitorcontrol.txt'))
B <- data.matrix(read.csv('inhibitorcontrolr.txt'))
wilcox.test(A, B, paired = FALSE, alternative = "two.sided", mu = 0.0,exact = FALSE, correct = TRUE, conf.int = TRUE, conf.level = 0.95)

A <- data.matrix(read.csv('inhibitorexpt.txt'))
B <- data.matrix(read.csv('inhibitorexptr.txt'))
wilcox.test(A, B, paired = FALSE, alternative = "two.sided", mu = 0.0,exact = FALSE, correct = TRUE, conf.int = TRUE, conf.level = 0.95)

A <- data.matrix(read.csv('coldelute.txt'))
B <- data.matrix(read.csv('coldeluter.txt'))
wilcox.test(A, B, paired = FALSE, alternative = "two.sided", mu = 0.0,exact = FALSE, correct = TRUE, conf.int = TRUE, conf.level = 0.95)
