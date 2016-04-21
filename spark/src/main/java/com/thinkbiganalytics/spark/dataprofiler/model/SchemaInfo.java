package com.thinkbiganalytics.spark.dataprofiler.model;

import java.util.HashMap;
import java.util.Map;

import org.apache.spark.sql.types.StructField;

/**
 * A helper class to hold the schema
 * @author jagrut sharma
 *
 */

public abstract class SchemaInfo {

	/**
	 * Mapping from column index to column schema
	 */
	public static Map<Integer, StructField> schemaMap = new HashMap<Integer, StructField>();

	/* no instantiation */
	private SchemaInfo() {}
}