�����

net.topology.node.switch.mapping.impl

Ĭ��ֵ��
org.apache.hadoop.net.ScriptBasedMapping
�����ͨ��һ���ű�ȥ��ȡ���ܸ�֪

��ֵ:
org.apache.hadoop.net.TableMapping
ָ�������ļ�(net.topology.table.file.name)����
�����ļ�Ҫ��ֻ�����У�ʹ�ÿո����\T�ָ��֧��#��ͷ��ע��
ӳ���ļ���һ����ip��ַ���ڶ�����/rack1(����Ҫб�ܿ�ͷ)



ʵ����������:
<property>
 <name>net.topology.node.switch.mapping.impl</name>
 <value>org.apache.hadoop.net.TableMapping</value>
</property>
<property>
 <name>net.topology.table.file.name</name>
 <value>/home/qiujw/hadoop/etc/hadoop/net-table</value>
</property>

net-table�ļ�:
10.1.74.44 /r1
10.1.74.45 /r1
10.1.74.46 /r2
10.1.74.47 /r2
10.1.74.48 /r2