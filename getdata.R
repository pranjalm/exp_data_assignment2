library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
by_year <- aggregate(Emissions~year,data = NEI,sum)
plot(by_year,type="l",main="PM2.5 trend in USA by all sources(1999-2008)")
balt <- aggregate(Emissions~year,data=NEI[NEI$fips=="24510",],sum)
plot(balt,type="l")
Pt_Source <- aggregate(Emissions~(year+type),
                       data = NEI[NEI$fips=="24510",],sum)
ggplot()+ geom_line(data = Pt_Source,aes(x = year,y =Emissions,
                                         group = type,colour = type))

coal <- SCC[grepl("Coal",SCC$EI.Sector),]
coal_src <- NEI[NEI$SCC %in% as.character(coal$SCC) , ]
coal_comb <- aggregate(Emissions~year,data = coal_src,sum)
plot(coal_comb,type="l")

mobile <- SCC[grepl("Mobile",SCC$EI.Sector),]
mobile_src <- NEI[NEI$SCC %in% as.character(mobile$SCC) & NEI$fips=="24510", ]
mobile_comb <- aggregate(Emissions~year,data = mobile_src,sum)
plot(mobile_comb,type="l")

mobile_src_comp <- NEI[NEI$SCC %in% as.character(mobile$SCC) & NEI$fips %in% c("06037","24510"), ]
mobile_comb_comp <- aggregate(Emissions~(year + fips),data = mobile_src_comp,sum)
ggplot()+ geom_line(data = mobile_comb_comp,aes(x = year,y =Emissions,
                                         group = fips,colour = fips))