/**
 * 
 */
package com.thinkbiganalytics.nifi.processors.metadata;

import java.util.List;

import org.apache.nifi.annotation.behavior.EventDriven;
import org.apache.nifi.annotation.behavior.InputRequirement;
import org.apache.nifi.annotation.documentation.CapabilityDescription;
import org.apache.nifi.annotation.documentation.Tags;
import org.apache.nifi.components.PropertyDescriptor;
import org.apache.nifi.flowfile.FlowFile;
import org.apache.nifi.processor.ProcessContext;

import com.thinkbiganalytics.controller.metadata.MetadataProvider;
import com.thinkbiganalytics.metadata.rest.model.data.Datasource;
import com.thinkbiganalytics.metadata.rest.model.data.HiveTableDatasource;
import com.thinkbiganalytics.metadata.rest.model.op.DataOperation;
import com.thinkbiganalytics.metadata.rest.model.op.Dataset;


/**
 *
 * @author Sean Felten
 */
@EventDriven
@InputRequirement(InputRequirement.Requirement.INPUT_ALLOWED)
@Tags({"feed", "termination", "thinkbig"})
@CapabilityDescription("Records the termination of a feed including the result of the process and table and partitions updated.")
public class HiveTableFeedTermination extends FeedTermination {

    @Override
    protected void addProperties(List<PropertyDescriptor> props) {
        super.addProperties(props);
        props.add(HiveTableProperties.DATABASE_NAME);
        props.add(HiveTableProperties.TABLE_NAME);
        props.add(HiveTableProperties.TABLE_LOCATION);
    }
    
    @Override
    protected Datasource createDestinationDatasource(ProcessContext context, String datasetName, String descr) {
        MetadataProvider provider = getProviderService(context).getProvider();
        String databaseName = context.getProperty(HiveTableProperties.DATABASE_NAME).getValue();
        String tableName = context.getProperty(HiveTableProperties.TABLE_NAME).getValue();
        
        return provider.ensureHiveTableDatasource(datasetName, "", databaseName, tableName);
    }
    
    @Override
    protected DataOperation completeOperation(ProcessContext context, 
                                              FlowFile flowFile, 
                                              Datasource dataset, 
                                              DataOperation op) {
        MetadataProvider provider = getProviderService(context).getProvider();
        HiveTableDatasource hds = (HiveTableDatasource) dataset;
        Dataset changeSet = provider.createDataset(hds, null);
        
        return provider.completeOperation(op.getId(), "", changeSet);
    }
}
