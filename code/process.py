#!/usr/bin/python
# -*- coding: UTF-8 -*-
from __future__ import division
from datetime import datetime
import csv
import numpy
import pymysql
from numpy import *
import numpy as np
from numpy import mean, median
import matplotlib.pyplot as plt
import math
import os
import seaborn as sns


path1 = os.path.abspath('.')  
path2 = os.path.abspath('..') 

conn = pymysql.connect(host='127.0.0.1', port=3306, user='amy', passwd='123456', db='FSE', charset='latin1')
cursor = conn.cursor()

version_date = ['2010-04-05', '2010-10-21', '2011-02-03', '2011-04-15', '2011-09-22', '2012-04-05', '2012-09-27',
                '2013-04-04', '2013-10-17', '2014-04-17', '2014-10-16', '2015-04-30', '2015-10-16', '2016-04-07',
                '2016-10-06', '2017-02-22']

# RQ1
com_manpower = []
idp_manpower = []
com_commit = []
idp_commit = []


for i in range(14):  
    start_time = datetime.date(datetime.strptime(version_date[i], '%Y-%m-%d'))
    end_time = datetime.date(datetime.strptime(version_date[i + 1], '%Y-%m-%d'))
    print start_time, end_time
    cursor.execute("SELECT count(distinct author_id), count(distinct id) "
                   "FROM icse19 "
                   "where date between %s and %s "
                   "and company is not null "
                   "and company not like 'independent' ", (start_time, end_time))

    res1 = cursor.fetchall()
    com_manpower.append(res1[0][0])
    com_commit.append(res1[0][1])

    cursor.execute("SELECT count(distinct author_id), count(distinct id) "
                   "FROM icse19 "
                   "where date between %s and %s "
                   "and company like 'independent' ", (start_time, end_time))

    res2 = cursor.fetchall()
    idp_manpower.append(res2[0][0])
    idp_commit.append(res2[0][1])

print "com_manpower\n", com_manpower
print "idp_manpower\n", idp_manpower
print "com_commit\n", com_commit
print "idp_commit\n", idp_commit

np.savetxt(path2 + "/data/com_manpower.csv", com_manpower, fmt="%f", delimiter=",")
np.savetxt(path2 + "/data/idp_manpower.csv", idp_manpower, fmt="%f", delimiter=",")
np.savetxt(path2 + "/data/com_commit.csv", com_commit, fmt="%f", delimiter=",")
np.savetxt(path2 + "/data/idp_commit.csv", idp_commit, fmt="%f", delimiter=",")

mean_com_manpower = mean(com_manpower)
mean_idp_manpower = mean(idp_manpower)
mean_com_commit = mean(com_commit)
mean_idp_commit = mean(idp_commit)

median_com_manpower = median(com_manpower)
median_idp_manpower = median(idp_manpower)
median_com_commit = median(com_commit)
median_idp_commit = median(idp_commit)

max_com_manpower = max(com_manpower)
max_idp_manpower = max(idp_manpower)
max_com_commit = max(com_commit)
max_idp_commit = max(idp_commit)

min_com_manpower = min(com_manpower)
min_idp_manpower = min(idp_manpower)
min_com_commit = min(com_commit)
min_idp_commit = min(idp_commit)



figsize = 6, 4
plt.figure(figsize=figsize)
release = range(0, len(com_manpower))
rel = [i + 0.3 for i in release]
plt.bar(release, com_manpower, color='black', width=.3, alpha=0.6, edgecolor="black", label='Hired by companies')
plt.bar(rel, idp_manpower, color='darkgrey', width=.3, alpha=0.4, edgecolor="black", label='Volunteers')
plt.xlabel('release')
plt.ylabel('# of developers')
plt.legend(loc='upper left')
plt.xticks(range(0, 14), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])
plt.savefig(path2 + "/figure/test.pdf", format='pdf')
plt.show()

plt.figure()
release = range(0, len(com_commit))
rel = [i + 0.3 for i in release]
plt.bar(release, com_commit, color='black', width=.3, alpha=0.6, edgecolor="black", label='Hired by companies')
plt.bar(rel, idp_commit, color='darkgrey', width=.3, alpha=0.4, edgecolor="black", label='Independent volunteers')
plt.xlabel('release')
plt.ylabel('# of commits')
plt.legend(loc='upper left')
plt.xticks(range(0, 14), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])
plt.savefig(path2 + "/figure/The number of commits submitted by companies and volunteers in OpenStack.pdf", format='pdf')
plt.show()

#RQ2:
def write_data(fileName="", dataList=[]):
    with open(fileName, "wb") as csvFile:
        csvWriter = csv.writer(csvFile)
        for data in dataList:
            data = [unicode(s).encode("utf-8") for s in data]
            csvWriter.writerow(data)
        csvFile.close


cursor.execute("SELECT company, count(distinct icse19.author_id) "
               "FROM icse19 "
               "where company is not null "
               "group by company "
               "order by count(distinct icse19.author_id) desc")
coms_manpower = cursor.fetchall()


cursor.execute("SELECT company, count(icse19.id) "
               "FROM icse19 "
               "where company is not null "
               "group by company "
               "order by count(icse19.id) desc")
coms_commits = cursor.fetchall()


def pie(coms, title, type):
    labels = []
    quants = []
    data = []
    others = 0
    num_other_com = 0
    for i in range(len(coms)):
        if i < 10:
            labels.append(coms[i][0])
            quants.append(coms[i][1])
            data.append([coms[i][1], coms[i][0]])
        else:
            others = others + coms[i][1]
            num_other_com = num_other_com + 1
    quants.append(others)
    labels.append(('others (#companies: ' + str(num_other_com) + ')'))
    data.append([others, ('others (#companies: ' + str(num_other_com) + ')')])

    print 'quants: ', quants
    print 'labels: ', labels
    np.savetxt(path2 + "/data/" + type + ".csv", data, fmt="%s", delimiter=",")
    plt.figure(1, figsize=(6, 6))
    explode = (0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0)  # explode=explode
    plt.pie(quants, labels=labels, labeldistance=1.3, autopct='%2.1f%%')
    plt.savefig(path2 + "/figure/" + title + ".pdf", format='pdf')
    plt.show()
pie(coms_manpower, "The manpower contributed by companies to OpenStack", "coms_manpower_pie10")
pie(coms_commits, "The commits contributed by companies to OpenStack", "coms_commits_pie10")

write_data(path2 + "/data/coms_manpower.csv", coms_manpower)
write_data(path2 + "/data/coms_commits.csv", coms_commits)


num_com_commit = []
num_com_manpower = []
all_manpower = []
all_commit = []
num_com = []

percent_80_commit = []
percent_80_manpower = []
for i in range(14): 
    start_time = datetime.date(datetime.strptime(version_date[i], '%Y-%m-%d'))
    end_time = datetime.date(datetime.strptime(version_date[i + 1], '%Y-%m-%d'))
    print start_time, end_time
    cursor.execute("SELECT count(distinct author_id), count(distinct id) "
                   "FROM icse19 "
                   "where date between %s and %s "
                   "and company is not null ", (start_time, end_time))
    res = cursor.fetchall()
    all_manpower.append(res[0][0])
    all_commit.append(res[0][1])

    cursor.execute("SELECT company, count(distinct author_id) "
                   "FROM icse19 "
                   "where date between %s and %s "
                   "and company is not null "
                   "group by company "
                   "order by count(distinct author_id) desc ", (start_time, end_time))
    each_com_manpower = cursor.fetchall()
    print "each_com_manpower\n", each_com_manpower

    num_com.append(len(each_com_manpower))

    for h in range(len(each_com_manpower)):
        num_com_manpower.append([i + 1, each_com_manpower[h][0], each_com_manpower[h][1]])

    cursor.execute("SELECT company, count(icse19.id) "
                   "FROM icse19 "
                   "where date between %s and %s "
                   "and company is not null "
                   "group by company "
                   "order by count(icse19.id) desc", (start_time, end_time))
    each_com_commits = cursor.fetchall()

    for j in range(len(each_com_commits)):
        num_com_commit.append([i + 1, each_com_commits[j][0], each_com_commits[j][1]])


def percent_80(ver_data, total):
    sum = 0
    count = 0
    all_com = len(ver_data)
    print ver_data
    print len(ver_data)
    print total
    for i in range(len(ver_data)):
        if sum > 0.8 * total:
            break
        else:
            sum += int(ver_data[i])
            count += 1
    percent = count / all_com
    print 'percent:', percent
    return percent, count, all_com

num_com_80dvpr = []
num_com_80cmt = []
num_com_alldvpr = []
num_com_allcmt = []


def percent_28(dataset, total, num_com, all_com):
    result = []
    for i in range(14):
        version_data = []
        for j in range(len(dataset)):
            if dataset[j][0] > i + 1:
                print version_data
                percent, count, allcom = percent_80(version_data, total[i])
                result.append(percent)
                num_com.append(count)
                all_com.append(allcom)
                break
            elif dataset[j][0] == i + 1:
                version_data.append(dataset[j][2])
            else:
                continue
        if i == 13:
            percent, count, allcom = percent_80(version_data, total[i])
            print percent, count
            result.append(percent)
            num_com.append(count)
            all_com.append(allcom)
    return result

percent_80_manpower = percent_28(num_com_manpower, all_manpower, num_com_80dvpr, num_com_alldvpr)
percent_80_commit = percent_28(num_com_commit, all_commit, num_com_80cmt, num_com_allcmt)
print 'percent_80_manpower', percent_80_manpower
print 'percent_80_commit', percent_80_commit
print 'num_com_80dvpr', num_com_80dvpr
print 'num_com_80cmt', num_com_80cmt
print "num_com_alldvpr", num_com_alldvpr
print "num_com_allcmt", num_com_allcmt


np.savetxt(path2 + "/data/num_com_80dvpr.csv", num_com_80dvpr, fmt="%d", delimiter=",")
np.savetxt(path2 + "/data/num_com_80cmt.csv", num_com_80cmt, fmt="%d", delimiter=",")
np.savetxt(path2 + "/data/num_com_alldvpr.csv", num_com_alldvpr, fmt="%d", delimiter=",")
np.savetxt(path2 + "/data/num_com_allcmt.csv", num_com_allcmt, fmt="%d", delimiter=",")

y1 = percent_80_manpower
y2 = percent_80_commit
x = range(0, 14)
figsize = 6, 4
plt.figure(figsize=figsize)
plt.plot(x, y1, '', label="developers", color='black', marker='*')
plt.plot(x, y2, '', label="commits", color='darkgrey', marker='o')
plt.legend(loc='upper right')
plt.xticks(range(0, 14), range(1, 15))
# plt.yticks(range(1, 10), (0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0))
plt.xlabel('release')
plt.ylabel('percentage of the total companies')
plt.grid(x)
plt.savefig(path2 + "/figure/test2.pdf",
            format='pdf')
plt.show()


def plot(Y, ylabel, title):
    y = Y
    x = range(0, 14)
    plt.plot(x, y, '', linewidth=2, color='r', marker='o', markerfacecolor='green', markersize=6)
    plt.xlabel('release')
    plt.ylabel(ylabel)
    plt.grid(x)
    plt.legend()
    plt.xticks(range(0, 14), range(1, 15))
    plt.savefig(path2 + "/figure/" + title + ".eps")
    plt.show()


plot(all_manpower, "# of developers", "The total number of developers contributed by companies to "
                                      "OpenStack from each release")
plot(all_commit, "# of commits", "The total number of commits contributed by companies to OpenStack from each release")
plot(num_com, "# of companies", "The total number of companies in OpenStack from each release")


y1 = num_com_80dvpr
y2 = num_com_80cmt
y3 = num_com
x = range(0, 14)
plt.figure()
plt.plot(x, y1, '', label="developers", color='g')
plt.plot(x, y2, '', label="commits", color='r')
plt.plot(x, y3, '', label="total", color='y')
plt.legend(loc='upper left')
plt.xticks(range(0, 14), range(1, 15))
plt.xlabel('release')
plt.ylabel('# of companies')
plt.grid(x)
plt.savefig(path2 + "/figure/The number of companies making 80% of contributions to OpenStack from each release.eps")
plt.show()



conn.commit()
cursor.close()
conn.close()