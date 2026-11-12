const d=db.getSiblingDB('isaacmart');
d.catalog.drop();
d.createCollection('catalog',{validator:{$jsonSchema:{bsonType:'object',required:['_id','sku','name','attributes'],properties:{_id:{bsonType:'int'},sku:{bsonType:'string'},name:{bsonType:'string'},attributes:{bsonType:'object'}}}}});
d.catalog.createIndex({sku:1},{unique:true});
d.catalog.insertMany([
 {_id:NumberInt(1),sku:'SKU-1',name:'Wireless headphones',attributes:{brand:'DemoSound',batteryHours:30,colour:'black'}},
 {_id:NumberInt(2),sku:'SKU-2',name:'Cotton shirt',attributes:{size:'L',material:'cotton',colour:'blue'}},
 {_id:NumberInt(3),sku:'SKU-3',name:'Desk lamp',attributes:{watts:12,colour:'white'}}
]);
print('Battery search:');printjson(d.catalog.find({'attributes.batteryHours':{$gte:20}}).toArray());
d.catalog.updateOne({_id:1},{$set:{'attributes.noiseCancellation':true}});
print('Updated product:');printjson(d.catalog.findOne({_id:1}));
try{d.catalog.insertOne({_id:NumberInt(4),sku:'SKU-1',name:'Duplicate',attributes:{}});throw Error('unique index failed');}catch(e){if(e.code!==11000)throw e;print('PASS duplicate SKU rejected, code '+e.code);}
try{d.catalog.insertOne({_id:NumberInt(5),sku:'SKU-5',name:'Invalid',attributes:'bad'});throw Error('validation failed');}catch(e){if(e.code!==121)throw e;print('PASS invalid attributes rejected, code '+e.code);}
print('Count: '+d.catalog.countDocuments({}));
print('MongoDB version: '+d.version());
