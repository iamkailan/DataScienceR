msleep
ggplot(data=msleep) +   
  
  # 散布圖對應的函式是geom_point()
  geom_point(aes(x=sleep_total,  # 用aes()，描繪散布圖內的各種屬性
                 y=bodywt,
                 main="Scatter Plot of bodywt-sleep_total") 
  ) + 
  # 用geom_smooth()加上趨勢線
  geom_smooth(aes(x=sleep_total,
                  y=bodywt)) +
  
  # 用labs()，進行文字上的標註(Annotation)
  labs(title="Scatter of sleep_total-bodywt",
       x="sleep_total",
       y="bodywt") +
  
  # 用theme_bw(background white)，改變主題背景成白色
  # 更多背景設定： http://docs.ggplot2.org/current/ggtheme.html            
  theme_bw()          

