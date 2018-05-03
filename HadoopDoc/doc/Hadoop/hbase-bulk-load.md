# Hbase Bulk Load

	������⣬���Σ�������ⶼ�����á�����mysql��load data����

## ����

1.	дHFile
2.	Bulk Load

## ����

���̽�����http://uestzengting.iteye.com/blog/1290557

## ʾ��
	
ʾ�����룺https://github.com/Paschalis/HBase-Bulk-Load-Example/blob/master/src/cy/ac/ucy/paschalis/hbase/bulkimport/Driver.java


---

��Ҫ��������һ��

	HFileOutputFormat
	LoadIncrementalHFiles		||	completebulkload tool

	HRegionInterface.bulkLoadHFiles
	HRegion.bulkLoadHFiles
	HStroe.assertBulkLoadHFileOk
	HFileScanner scanner = reader.getScanner	������֤
	store.bulkLoadHFile(path);
	StoreFile.rename(fs, srcPath, dstPath);

	hadoop jar   /usr/lib/hbase/hbase-0.94.6-cdh4.3.0-
	security.jar importtsv
	-Dimporttsv.separator=,
	-Dimporttsv.bulk.output=output
	-Dimporttsv.columns=HBASE_ROW_KEY,f:count wordcount word_count.csv



	Here��s a rundown of the different configuration elements:

	-Dimporttsv.separator=, specifies that the separator is a comma.
	-Dimporttsv.bulk.output=output is a relative path to where the HFiles will be written. Since your user on the VM is ��cloudera�� by default, it means the files will be in /user/cloudera/output. Skipping this option will make the job write directly to HBase.
	-Dimporttsv.columns=HBASE_ROW_KEY,f:count is a list of all the columns contained in this file. The row key needs to be identified using the all-caps HBASE_ROW_KEY string; otherwise it won��t start the job. (I decided to use the qualifier ��count�� but it could be anything else.)
	
	
	
	hadoop jar hbase-VERSION.jar completebulkload /user/todd/myoutput mytable
	
	
	
	hbase.hstore.bulkload.verify һ�����أ�Ĭ�Ϲرգ�����store�����ϵ�������֤��