package js.documentdb;

import externtype.Mixed2;
import externtype.ValueOrArray;
import haxe.Constraints.Function;
import js.node.Buffer;
import js.node.stream.Readable;

@:jsRequire("documentdb", "DocumentClient")
extern class DocumentClient {
    /**
     * Constructs a DocumentClient.
     * @param urlConnection           - The service endpoint to use to create the client.
     * @param auth                    - An object that is used for authenticating requests and must contains one of the options.
     * @param connectionPolicy        - An instance of {@link ConnectionPolicy} class. This parameter is optional and the default connectionPolicy will be used if omitted.
     * @param consistencyLevel        - An optional parameter that represents the consistency level. It can take any value from {@link ConsistencyLevel}.
     */
    function new(urlConnection: String, auth: AuthOptions, ?connectionPolicy: ConnectionPolicy, ?consistencyLevel: ConsistencyLevel);

    /**
     * Send a request for creating a database.
     *  A database manages users, permissions and a set of collections.
     *  Each Azure DocumentDB Database Account is able to support multiple independent named databases, with the database being the logical container for data.
     *  Each Database consists of one or more collections, each of which in turn contain one or more documents. Since databases are an an administrative
     *  resource, the Service Master Key will be required in order to access and successfully complete any action using the User APIs.
     * @param body      - A json object that represents The database to be created.
     * @param options   - The request options.
     * @param callback  - The callback for the request.
     */
    function createDatabase(body: Database, ?options: RequestOptions, callback: RequestCallback<RetrievedDatabase>): Void;

    /**
     * Lists all databases that satisfy a query.
     * @param query     - A SQL query string.
     * @param [options] - The feed options.
     * @returns         - An instance of QueryIterator to handle reading feed.
     */
    function queryDatabases(query: Mixed2<String, SqlQuerySpec>, ?options: FeedOptions): QueryIterator<Dynamic>;

    /**
     * Read a database.
     * @param databaseLink      - The self-link of the database.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    @:overload(function (databaseLink: String, callback: RequestCallback<RetrievedDatabase>): Void {})
    function readDatabase(databaseLink: String, options: RequestOptions, callback: RequestCallback<RetrievedDatabase>): Void;

    /**
     * List all databases.
     * @param options       - The request options.
     */
    function readDatabases(?options: FeedOptions): QueryIterator<RetrievedDatabase>;

    /**
     * Delete the database object.
     * @param databaseLink  - The self-link of the database.
     * @param [options]     - The request options.
     * @param callback      - The callback for the request.
     */
    function deleteDatabase(databaseLink: String, ?options: RequestOptions, callback: RequestCallback<Void>): Void;

    /**
     * Creates a collection.
     * <p>
     * A collection is a named logical container for documents. <br>
     * A database may contain zero or more named collections and each collection consists of zero or more JSON documents. <br>
     * Being schema-free, the documents in a collection do not need to share the same structure or fields. <br>
     * Since collections are application resources, they can be authorized using either the master key or resource keys. <br>
     * </p>
     * @param databaseLink  - The self-link of the database.
     * @param body          - Represents the body of the collection.
     * @param [options]     - The request options.
     * @param callback      - The callback for the request.
     */
    function createCollection(databaseLink: String, body: Collection, ?options: RequestOptions, callback: RequestCallback<RetrievedCollection>): Void;

    /**
     * Query the collections for the database.
     * @param databaseLink  - The self-link of the database.
     * @param query         - A SQL query string.
     * @param [options]     - Represents the feed options.
     * @returns             - An instance of queryIterator to handle reading feed.
     */
    function queryCollections(databaseLink: String, query: Mixed2<String, SqlQuerySpec>, ?options: FeedOptions): QueryIterator<Dynamic>;

    /**
     * Read a collection.
     * @param collectionLink    - The self-link of the collection.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function readCollection(collectionLink: String, ?options: RequestOptions, callback: RequestCallback<RetrievedCollection>): Void;

    /**
     * Get all collections in this database.
     * @param databaseLink      - The self-link of the database.
     * @param options           - The feed options.
     */
    function readCollections(databaseLink: String, ?options: FeedOptions): QueryIterator<RetrievedCollection>;

    /**
     * Replace the document collection.
     * @param collectionLink    - The self-link of the document collection.
     * @param collection        - Represent the new document collection body.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function replaceCollection(collectionLink: String, collection: Collection, ?options: RequestOptions, callback: RequestCallback<RetrievedCollection>): Void;

    /**
     * Delete the collection object.
     * @param collectionLink    - The self-link of the collection.
     * @param [options]         - The request options.
     * @param callback          - The callback for the request.
     */
    function deleteCollection(collectionLink: String, ?options: RequestOptions, callback: RequestCallback<Void>): Void;

    /**
     * Create a document.
     * <p>
     * There is no set schema for JSON documents. They may contain any number of custom properties as well as an optional list of attachments. <br>
     * A Document is an application resource and can be authorized using the master key or resource keys
     * </p>
     * @param documentsFeedOrDatabaseLink    - The self-link of the collection.
     * @param body              - Represents the body of the document. Can contain any number of user defined properties.
     * @param [options]         - The request options.
     * @param callback 			- The callback for the request.
     */
    @:overload(function<TBody: Document>(documentsFeedOrDatabaseLink: String, body: TBody, callback: RequestCallback<RetrievedDocument>): Void {})
    function createDocument<TBody: Document>(documentsFeedOrDatabaseLink: String, body: TBody, options: DocumentOptions, callback: RequestCallback<RetrievedDocument>): Void;

    /**
     * Upsert a document.
     * <p>
     *  There is no set schema for JSON documents. They may contain any number of custom properties as well as an optional list of attachments.
     *  A Document is an application resource and can be authorized using the master key or resource keys
     * </p>
     * @param documentsFeedOrDatabaseLink   - The collection link or database link if using a partition resolver
     * @param body          - Represents the body of the document. Can contain any number of user defined properties.
     * @param [options]     - The request options.
     * @param callback      - The callback for the request.
     */
    @:overload(function<TBody: Document>(documentsFeedOrDatabaseLink: String, body: TBody, callback: RequestCallback<RetrievedDocument>): Void {})
    function upsertDocument<TBody: Document>(documentsFeedOrDatabaseLink: String, body: TBody, options: DocumentOptions, callback: RequestCallback<RetrievedDocument>): Void;

    /**
     * Query the documents for the collection.
     * @param collectionLink - The self-link of the collection.
     * @param query          - A SQL query string.
     * @param [options]      - Represents the feed options.
     * @returns              - An instance of queryIterator to handle reading feed.
     */
    function queryDocuments(collectionLink: String, query: Mixed2<String, SqlQuerySpec>, ?options: FeedOptions): QueryIterator<Dynamic>;

    /**
     * Read a document.
     * @param documentLink      - The self-link of the document.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function readDocument(documentLink: String, ?options: RequestOptions, callback: RequestCallback<RetrievedDocument>): Void;

    /**
     * Get all documents in this collection.
     * @param collectionLink    - The self-link of the collection.
     * @param options           - The feed options.
     */
    function readDocuments(collectionLink: String, ?options: FeedOptions): QueryIterator<RetrievedDocument>;

    /**
     * Replace the document object.
     * @param documentLink      - The self-link of the document.
     * @param document          - Represent the new document body.
     * @param [options] - The request options.
     * @param callback - The callback for the request.
     */
    function replaceDocument<TBody: Document>(documentLink: String, document: TBody, ?options: RequestOptions, callback: RequestCallback<RetrievedDocument>): Void;

    /**
     * Delete the document object.
     * @param documentLink  - The self-link of the document.
     * @param [options]     - The request options.
     * @param callback      - The callback for the request.
     */
    function deleteDocument(documentLink: String, ?options: RequestOptions, callback: RequestCallback<Void>): Void;

    /**
     * Create an attachment for the document object.
     * <p>
     *  Each document may contain zero or more attachments. Attachments can be of any MIME type - text, image, binary data. <br>
     *  These are stored externally in Azure Blob storage. Attachments are automatically deleted when the parent document is deleted.
     * </p>
     * @param documentLink  - The self-link of the document.
     * @param body          - The metadata the defines the attachment media like media, contentType. It can include any other properties as part of the metedata
     * @param [options]     - The request options.
     * @param callback      - The callback for the request.
     */
    function createAttachment<TBody: Attachment, TRetrieved: RetrievedAttachment>(
            documentLink: String, body: TBody, ?options: RequestOptions, callback: RequestCallback<TRetrieved>): Void;

    /**
     * Create an attachment with media file for the document object.
     * @param documentLink      - The self-link of the DatabaseAccountRequestOptions.
     * @param readableStream    - The stream that represents the media itself that needs to be uploaded.
     * @param [options]         - The request options.
     * @param callback          - The callback for the request.
     */
    function createAttachmentAndUploadMedia(documentLink: String, readableStream: Readable<Dynamic>, ?options: MediaOptions, callback: RequestCallback<RetrievedAttachment>): Void;

    /**
     * Upsert an attachment for the document object.
     * <p>
     *  Each document may contain zero or more attachments. Attachments can be of any MIME type - text, image, binary data.
     *  These are stored externally in Azure Blob storage. Attachments are automatically deleted when the parent document is deleted.
     * </p>
     * @param documentLink  - The self-link of the document.
     * @param body          - The metadata the defines the attachment media like media, contentType. It can include any other properties as part of the metedata.
     * @param options       - The request options.
     * @param callback      - The callback for the request.
     */
    function upsertAttachment<TBody: Attachment, TRetrieved: RetrievedAttachment>(
            documentLink: String, body: TBody, ?options: RequestOptions, callback: RequestCallback<TRetrieved>): Void;

    /**
     * Upsert an attachment for the document object.
     * @param documentLink      - The self-link of the document.
     * @param readableStream    - the stream that represents the media itself that needs to be uploaded.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function upsertAttachmentAndUploadMedia(
            documentLink: String, readableStream: Readable<Dynamic>, ?options: MediaOptions, callback: RequestCallback<Dynamic>): Void;

    /**
     * Query the attachments for the document.
     * @param documentLink      - The self-link of the document.
     * @param query             - A SQL query.
     * @param [options]         - Represents the feed options.
     */
    function queryAttachments(documentLink: String, query: Mixed2<String, SqlQuerySpec>, ?options: FeedOptions): QueryIterator<Dynamic>;

    /**
     * Read an Attachment object.
     * @param attachmentLink    - The self-link of the attachment.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function readAttachment<TRetrieved: RetrievedAttachment>(
            attachmentLink: String, ?options: RequestOptions, callback: RequestCallback<TRetrieved>): Void;

    /**
     * Get all attachments for this document.
     * @param documentLink      - The self-link of the document.
     * @param options           - The feed options.
     */
    function readAttachments<TRetrieved: RetrievedAttachment>(
            documentLink: String, ?options: FeedOptions): QueryIterator<TRetrieved>;

    /**
     * Read the media for the attachment object.
     * @param mediaLink     - The media link of the media in the attachment.
     * @param callback      - The callback for the request, the result parameter can be a buffer or a stream depending on the value of MediaReadMode
     */
    function readMedia(mediaLink: String, callback: RequestCallback<Mixed2<Buffer, Readable<Dynamic>>>): Void;

    /**
     * Replace the attachment object.
     * @param attachmentLink    - The self-link of the attachment.
     * @param attachment        - Represent the new attachment body.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function replaceAttachment<TBody: Attachment, TRetrieved: RetrievedAttachment>(
            attachmentLink: String, attachment: TBody, ?options: RequestOptions, callback: RequestCallback<TRetrieved>): Void;

    /**
     * Update media for the attachment
     * @param mediaLink         - The media link of the media in the attachment.
     * @param readableStream    - The stream that represents the media itself that needs to be uploaded.
     * @param options           - options for the media
     * @param callback          - The callback for the request.
     */
    function updateMedia(mediaLink: String, readableStream: Readable<Dynamic>, ?options: MediaOptions, callback: RequestCallback<Dynamic>): Void;

    /**
     * Delete an attachment
     * @param attachmentLink    - The self-link of the attachment.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function deleteAttachment(attachmentLink: String, ?options: RequestOptions, callback: RequestCallback<Void>): Void;

    /**
     * Create a trigger.
     * <p>
     * DocumentDB supports pre and post triggers defined in JavaScript to be executed on creates, updates and deletes. <br>
     * For additional details, refer to the server-side JavaScript API documentation.
     * </p>
     * @param collectionLink  - The self-link of the collection.
     * @param trigger         - Represents the body of the trigger.
     * @param [options]       - The request options.
     * @param callback        - The callback for the request.
     */
    function createTrigger(collectionLink: String, trigger: Trigger, ?options: RequestOptions, callback: RequestCallback<RetrievedTrigger>): Void;

    /**
     * Upsert a trigger.
     * <p>
     *  DocumentDB supports pre and post triggers defined in JavaScript to be executed on creates, updates and deletes.
     *  For additional details, refer to the server-side JavaScript API documentation.
     * </p>
     * @param collectionLink    - The self-link of the collection.
     * @param trigger           - Represents the body of the trigger.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function upsertTrigger(collectionLink: String, trigger: Trigger, ?options: RequestOptions, callback: RequestCallback<RetrievedTrigger>): Void;

    /**
     * Query the triggers for the collection.
     * @param collectionLink         - The self-link of the collection.
     * @param query   - A SQL query.
     * @param [options]         - Represents the feed options.
     * @returns               - An instance of queryIterator to handle reading feed.
     */
    function queryTriggers(collectionLink: String, query: Mixed2<String, SqlQuerySpec>, ?options: FeedOptions): QueryIterator<Dynamic>;

    /**
     * Reads a trigger object.
     * @param triggerLink       - The self-link of the trigger.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function readTrigger(triggerLink: String, ?options: RequestOptions, callback: RequestCallback<RetrievedTrigger>): Void;

    /**
     * Get all triggers in this collection.
     * @param collectionLink    - The self-link of the collection.
     * @param options           - The feed options.
     */
    function readTriggers(collectionLink: String, ?options: FeedOptions): QueryIterator<RetrievedTrigger>;

    /**
     * Replace the trigger object.
     * @param triggerLink   - The self-link of the trigger.
     * @param trigger       - Represent the new trigger body.
     * @param options       - The request options.
     * @param callback      - The callback for the request.
     */
    function replaceTrigger(triggerLink: String, trigger: Trigger, ?options: RequestOptions, callback: RequestCallback<RetrievedTrigger>): Void;

    /**
     * Delete a trigger
     * @param triggerLink       - The self-link of the trigger.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function deleteTrigger(triggerLink: String, ?options: RequestOptions, callback: RequestCallback<Void>): Void;

    /**
     * Create a StoredProcedure.
     * <p>
     * DocumentDB allows stored procedures to be executed in the storage tier, directly against a document collection. The script <br>
     * gets executed under ACID transactions on the primary storage partition of the specified collection. For additional details, <br>
     * refer to the server-side JavaScript API documentation.
     * </p>
     * @param collectionLink    - The self-link of the collection.
     * @param procedure         - Represents the body of the stored procedure.
     * @param [options]         - The request options.
     * @param callback          - The callback for the request.
     */
    function createStoredProcedure(collectionLink: String, procedure: StoredProcedure, ?options: RequestOptions, callback: RequestCallback<RetrievedStoredProcedure>): Void;

    /**
     * Upsert a StoredProcedure.
     * <p>
     *  DocumentDB allows stored procedures to be executed in the storage tier, directly against a document collection. The script
     *  gets executed under ACID transactions on the primary storage partition of the specified collection. For additional details,
     *  refer to the server-side JavaScript API documentation.
     * </p>
     * @param collectionLink    - The self-link of the collection.
     * @param sproc             - Represents the body of the stored procedure.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function upsertStoredProcedure(collectionLink: String, sproc: StoredProcedure, ?options: RequestOptions, callback: RequestCallback<RetrievedStoredProcedure>): Void;

    /**
     * Query the storedProcedures for the collection.
     * @param collectionLink    - The self-link of the collection.
     * @param query             - A SQL query string.
     * @param [options]         - Represents the feed options.
     * @returns                 - An instance of queryIterator to handle reading feed.
     */
    function queryStoredProcedures(collectionLink: String, query: Mixed2<String, SqlQuerySpec>, ?options: FeedOptions): QueryIterator<Dynamic>;

    /**
     * Read a stored procedure
     * @param procedureLink     - The self-link of the stored procedure.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function readStoredProcedure(procedureLink: String, ?options: RequestOptions, callback: RequestCallback<RetrievedStoredProcedure>): Void;

    /**
     * Get all StoredProcedures in this collection.
     * @param collectionLink    - The self-link of the collection.
     * @param options           - The feed options.
     */
    function readStoredProcedures(collectionLink: String, ?options: RequestOptions): QueryIterator<RetrievedStoredProcedure>;

    /**
     * Replace the StoredProcedure object.
     * @param procedureLink - The self-link of the stored procedure.
     * @param procedure     - Represent the new procedure body.
     * @param [options]     - The request options.
     * @param callback      - The callback for the request.
     */
    function replaceStoredProcedure(procedureLink: String, procedure: StoredProcedure, ?options: RequestOptions, callback: RequestCallback<RetrievedStoredProcedure>): Void;

    /**
     * Execute the StoredProcedure represented by the object.
     * @param procedureLink - The self-link of the stored procedure.
     * @param [params]      - Represents the parameters of the stored procedure.
     * @param options       - The request options
     * @param callback      - The callback for the request.
     */
    function executeStoredProcedure(procedureLink: String, ?params: Array<Dynamic>, ?options: RequestOptions, callback: RequestCallback<Dynamic>): Void;

    /**
     * Delete the StoredProcedure object.
     * @param procedureLink - The self-link of the stored procedure.
     * @param [options]     - The request options.
     * @param callback      - The callback for the request.
     */
    function deleteStoredProcedure(procedureLink: String, ?options: RequestOptions, callback: RequestCallback<Void>): Void;

    /**
     * Create a UserDefinedFunction.
     * <p>
     * DocumentDB supports JavaScript UDFs which can be used inside queries, stored procedures and triggers. <br>
     * For additional details, refer to the server-side JavaScript API documentation.
     * </p>
     * @param collectionLink    - The self-link of the collection.
     * @param udf               - Represents the body of the userDefinedFunction.
     * @param [options]         - The request options.
     * @param callback          - The callback for the request.
     */
    function createUserDefinedFunction(collectionLink: String, udf: UserDefinedFunction, ?options: RequestOptions, callback: RequestCallback<RetrievedUserDefinedFunction>): Void;

    /**
     * Upsert a UserDefinedFunction.
     * <p>
     *  DocumentDB supports JavaScript UDFs which can be used inside queries, stored procedures and triggers.
     *  For additional details, refer to the server-side JavaScript API documentation.
     * </p>
     * @param collectionLink    - The self-link of the collection.
     * @param udf               - Represents the body of the userDefinedFunction.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function upsertUserDefinedFunction(collectionLink: String, udf: UserDefinedFunction, ?options: RequestOptions, callback: RequestCallback<RetrievedUserDefinedFunction>): Void;

    /**
     * Query the user-defined functions for the collection.
     * @param collectionLink    - The self-link of the collection.
     * @param query             - A SQL query string.
     * @param [options]         - Represents the feed options.
     * @returns                 - An instance of queryIterator to handle reading feed.
     */
    function queryUserDefinedFunctions(collectionLink: String, query: Mixed2<String, SqlQuerySpec>, ?options: FeedOptions): QueryIterator<Dynamic>;

    /**
     * Reads a udf object.
     * @param udfLink   - The self-link of the user defined function.
     * @param options   - The request options.
     * @param callback  - The callback for the request.
     */
    function readUserDefinedFunction(udfLink: String, ?options: RequestOptions, callback: RequestCallback<RetrievedUserDefinedFunction>): Void;

    /**
     * Get all UserDefinedFunctions in this collection.
     * @param collectionLink    - The self-link of the collection.
     * @param options           - The feed options.
     */
    function readUserDefinedFunctions(collectionLink: String, ?options: FeedOptions): QueryIterator<RetrievedUserDefinedFunction>;

    /**
     * Replace the UserDefinedFunction object.
     * @param udfLink       - The self-link of the user defined function.
     * @param udf           - Represent the new udf body.
     * @param options       - The request options.
     * @param callback      - The callback for the request.
     */
    function replaceUserDefinedFunction(udfLink: String, udf: UserDefinedFunction, ?options: RequestOptions, callback: RequestCallback<RetrievedUserDefinedFunction>): Void;

    /**
     * Delete a user-defined function
     * @param udfLink           - The self-link of the user defined function.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function deleteUserDefinedFunction(udfLink: String, ?options: RequestOptions, callback: RequestCallback<Void>): Void;

    /**
     * Lists all offers that satisfy a query.
     * @param query     - A SQL query.
     * @param options   - The feed options.
     */
    function queryOffers(query: Mixed2<String, SqlQuerySpec>, ?options: FeedOptions): QueryIterator<Dynamic>;

    /**
     * Read an offer.
     * @param offerLink     - The self-link of the offer.
     * @param callback      - The callback for the request.
     */
    function readOffer(offerLink: String, callback: RequestCallback<RetrievedOffer>): Void;

    /**
     * List all offers
     * @param options       - The feed options.
     */
    function readOffers(?options: FeedOptions): QueryIterator<Array<RetrievedOffer>>;

    /**
     * Replace the offer object.
     * @param offerLink     - The self-link of the offer.
     * @param offer         - Represent the new offer body.
     * @param callback      - The callback for the request.
     */
    function replaceOffer(offerLink: String, offer: Offer, callback: RequestCallback<RetrievedOffer>): Void;

    /**
     * Query the conflicts for the collection.
     * @param collectionLink    - The self-link of the collection.
     * @param query             - A SQL query.
     * @param [options]         - Represents the feed options.
     */
    function queryConflicts(collectionLink: String, query: Mixed2<String, SqlQuerySpec>, ?options: FeedOptions): QueryIterator<Dynamic>;

    /**
     * Read a conflict.
     * @param conflictLink      - The self-link of the conflict.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function readConflict(conflictLink: String, ?options: RequestOptions, callback: RequestCallback<Dynamic>): Void;

    /**
     * Get all conflicts in this collection.
     * @param collectionLink    - The self-link of the collection.
     * @param options           - The feed options.
     */
    function readConflicts(collectionLink: String, ?options: FeedOptions): QueryIterator<Dynamic>;

    /**
     * Delete a conflict
     * @param conflictLink      - The self-link of the conflict.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function deleteConflict(conflictLink: String, ?options: RequestOptions, callback: RequestCallback<Void>): Void;

    /**
     * Create a user
     * @param databaseLink  - The self-link of the database.
     * @param body          - Represents the body of the user.
     * @param options       - The request options.
     * @param callback      - The callback for the request.
     */
    function createUser(databaseLink: String, body: User, ?options: RequestOptions, callback: RequestCallback<RetrievedUser>): Void;

    /**
     * Upsert a database user.
     * @param databaseLink  - The self-link of the database.
     * @param body          - Represents the body of the user.
     * @param options       - The request options.
     * @param callback      - The callback for the request.
     */
    function upsertUser(databaseLink: String, body: User, ?options: RequestOptions, callback: RequestCallback<RetrievedUser>): Void;

    /**
     * Query the users for the database.
     * @param databaseLink  - The self-link of the database.
     * @param query         - A SQL query.
     * @param options       - Represents the feed options.
     */
    function queryUsers(databaseLink: String, query: Mixed2<String, SqlQuerySpec>, ?options: FeedOptions): QueryIterator<Dynamic>;

    /**
     * Reads a user.
     * @param userLink  - The self-link of the user.
     * @param options   - The request options.
     * @param callback  - The callback for the request.
     */
    function readUser(userLink: String, ?options: RequestOptions, callback: RequestCallback<RetrievedUser>): Void;

    /**
     * Get all users in this database.
     * @param databaseLink      - The self-link of the database.
     * @param feedOptions       - The feed options.
     */
    function readUsers(databaseLink: String, ?feedOptions: FeedOptions): QueryIterator<Array<RetrievedUser>>;

    /**
     * Replace the user object.
     * @param userLink      - The self-link of the user.
     * @param user          - Represent the new user body.
     * @param options       - The request options.
     * @param callback      - The callback for the request.
     */
    function replaceUser(userLink: String, user: User, options: RequestOptions, callback: RequestCallback<RetrievedUser>): Void;

    /**
     * Delete a user
     * @param userLink          - The self-link of the user.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function deleteUser(userLink: String, ?options: RequestOptions, callback: RequestCallback<Void>): Void;

    /**
     * Create a permission. A permission represents a per-User Permission to access a specific resource e.g. Document or Collection.
     * @param userLink      - Self-link of the user.
     * @param body          - Permission body
     * @param options       - Request options
     * @param callback      - Callback for the request
     */
    function createPermission(userLink: String, body: Permission, options: RequestOptions, callback: RequestCallback<RetrievedPermission>): Void;

    /**
     * Upsert a permission.
     * <p>
     *  A permission represents a per-User Permission to access a specific resource e.g. Document or Collection.
     * </p>
     * @param userLink  - The self-link of the user.
     * @param body      - Represents the body of the permission.
     * @param options   - The request options.
     * @param callback  - The callback for the request.
     */
    function upsertPermission(userLink: String, body: Permission, ?options: RequestOptions, callback: RequestCallback<RetrievedPermission>): Void;

    /**
     * Query the permission for the user.
     * @param userLink  - The self-link of the user.
     * @param query     - A SQL query.
     * @param options   - Feed options.
     */
    function queryPermissions(userLink: String, query: Mixed2<String, SqlQuerySpec>, ?options: FeedOptions): QueryIterator<Dynamic>;

    /**
     * Read a permission.
     * @param permissionLink    - The self-link of the permission.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function readPermission(permissionLink: String, ?options: RequestOptions, callback: RequestCallback<RetrievedPermission>): Void;

    /**
     * Get all permissions for this user.
     * @param userLink          - The self-link of the user.
     * @param feedOptions       - The feed options
     */
    function readPermissions(userLink: String, ?feedOptions: FeedOptions): QueryIterator<RetrievedPermission>;

    /**
     * Replace the permission object.
     * @param permissionLink    - The self-link of the permission.
     * @param permission        - Represent the new permission body.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function replacePermission(permissionLink: String, permission: Permission, options: RequestOptions, callback: RequestCallback<RetrievedPermission>): Void;

    /**
     * Delete a permission
     * @param permissionLink    - The self-link of the permission.
     * @param options           - The request options.
     * @param callback          - The callback for the request.
     */
    function deletePermission(permissionLink: String, ?options: RequestOptions, callback: RequestCallback<Void>): Void;

    /**
     * Gets the Database account information.
     * @param options       - The request options
     * @param callback      - The callback for the request
     */
    function getDatabaseAccount(?options: DatabaseAccountRequestOptions, callback: RequestCallback<DatabaseAccount>): Void;

    /**
     * Gets the curent read endpoint for a geo-replicated database account.
     * @param callback      - The callback for the request
     */
    function getReadEndpoint(callback: RequestCallback<String>): Void;

    /**
     * Gets the curent write endpoint for a geo-replicated database account.
     * @param callback      - The callback for the request
     */
    function getWriteEndpoint(callback: RequestCallback<String>): Void;
}

/** An object that is used for authenticating requests and must contain one of the options. */
typedef AuthOptions = {
    /** The authorization master key to use to create the client. */
    @:optional var masterKey(default, default): String;

    /** An object that contains resources tokens. Keys for the object are resource Ids and values are the resource tokens. */
    @:optional var resourceTokens(default, default): Dynamic<String>;

    /** An array of {@link Permission} objects. */
    @:optional var permissionFeed(default, default): Array<Permission>;
}

/** ConnectionPolicy */
typedef ConnectionPolicy = {
    /** Attachment content (aka media) download mode.  */
    var MediaReadMode(default, default): MediaReadMode;

    /** Time to wait for response from network peer for attachment content (aka media) operations. Represented in milliseconds. */
    var MediaRequestTimeout(default, default): Int;

    /** Request timeout (time to wait for response from network peer). Represented in milliseconds. */
    var RequestTimeout(default, default): Int;

    /** Flag to enable/disable automatic redirecting of requests based on read/write operations. */
    var EnableEndpointDiscovery(default, default): Bool;

    /** List of azure regions to be used as preferred locations for read requests. */
    var PreferredLocations(default, default): Array<String>;

    /** RetryOptions instance which defines several configurable properties used during retry. */
    var RetryOptions(default, default): RetryOptions;

    /**
     * Flag to disable SSL verification for the requests.
     * SSL verification is enabled by default. Don't set this when targeting production endpoints.
     * This is intended to be used only when targeting emulator endpoint to avoid failing your requests with SSL related error.
     */
    var DisableSSLVerification(default, default): Bool;
}

@:enum abstract MediaReadMode(String) {
    var Buffered = "Buffered";
    var Streamed = "Streamed";
}

/** RetryOptions */
typedef RetryOptions = {
    /** Max number of retries to be performed for a request. Default value 9. */
    @:optional var MaxRetryAttemptCount(default, default): Int;

    /** Fixed retry interval in milliseconds to wait between each retry ignoring the retryAfter returned as part of the response. */
    @:optional var FixedRetryIntervalInMilliseconds(default, default): Int;

    /** Max wait time in seconds to wait for a request while the retries are happening. Default value 30 seconds. */
    @:optional var MaxWaitTimeInSeconds(default, default): Int;
}

@:enum abstract ConsistencyLevel(String) {
    var Strong = "Strong";
    var BoundedStaleness = "BoundedStaleness";
    var Session = "Session";
    var ConsistentPrefix = "ConsistentPrefix";
    var Eventual = "Eventual";
}

/** Options that can be specified for a request issued to the DocumentDB servers. */
typedef RequestOptions = {
    /** Indicates what is the pre trigger to be invoked before the operation. */
    @:optional var preTriggerInclude(default, default): String;

    /** Indicates what is the post trigger to be invoked after the operation. */
    @:optional var postTriggerInclude(default, default): String;

    /** Conditions Associated with the request. */
    @:optional var accessCondition(default, default): {
        /** Conditional HTTP method header type. */
        var type(default, default): String;

        /** Conditional HTTP method header value. */
        var condition(default, default): String;
    };

    /** Specifies indexing directives (index, do not index ..etc). */
    @:optional var indexingDirective(default, default): String;

    /** Consistency level required by the client. */
    @:optional var consistencyLevel(default, default): ConsistencyLevel;

    /** Token for use with Session consistency. */
    @:optional var sessionToken(default, default): String;

    /** Expiry time (in seconds) for resource token associated with permission (applicable only for requests on permissions). */
    @:optional var resourceTokenExpirySeconds(default, default): Int;

    /** Offer type when creating document collections. */
    @:optional var offerType(default, default): String;

    /**
     * The user-specified throughput when creating document collections.
     *
     * Expressed in units of 100 request units per second. This can be between 400 and 250,000 (or higher by requesting a limit increase).
     *
     * If the x-ms-offer-throughput is over 10,000, then the collection must include a partitionKey definition.
     * If the x-ms-offer-throughput is equal to or under 10,000, then the collection must not include a partitionKey definition.
     *
     * One of x-ms-offer-throughput or x-ms-offer-type must be specified. Both headers cannot be specified together.
     */
    @:optional var offerThroughput(default, default): Int;

    /**
     * The partition key value for the requested document or attachment operation.
     *
     * Required for operations against documents and attachments when the collection definition includes a partition key definition.
     */
    @:optional var partitionKey(default, default): String;

    /**
     * Allow execution across multiple partitions
     *
     * If the collection is partitioned, this must be set to True unless the query filters against a single partition key
     * or if the collection has only a single partition.
     */
    @:optional var enableCrossPartitionQuery(default, default): Bool;

    /** If true, parallelize cross-partition queries */
    @:optional var maxDegreeOfParallelism(default, default): Bool;

    /** If true, populate quota in response */
    @:optional var populateQuotaInfo(default, default): Bool;
}

/** The feed options and query methods. */
typedef FeedOptions = {>RequestOptions,
    /** Max number of items to be returned in the enumeration operation. */
    @:optional var maxItemCount(default, default): Int;

    /** Opaque token for continuing the enumeration. */
    @:optional var continuation(default, default): String;

    /** Token for use with Session consistency. */
    @:optional var sessionToken(default, default): String;

    /** Allow scan on the queries which couldn't be served as indexing was opted out on the requested paths. */
    @:optional var enableScanInQuery(default, default): Bool;
}

typedef DocumentOptions = {>RequestOptions,
    /** Disables the automatic id generation. If id is missing in the body and this option is true, an error will be returned. */
    @:optional var disableAutomaticIdGeneration(default, default): Bool;
}

typedef MediaOptions = {>RequestOptions,
    /** HTTP Slug header value. */
    @:optional var slug(default, default): String;
    /** HTTP ContentType header value. */
    @:optional var contentType(default, default): String;
}

typedef DatabaseAccountRequestOptions = {>RequestOptions,
    /** The endpoint url whose database account needs to be created. If not present, current client's url will be used. */
    @:optional var urlConnection(default, default): String;
}

/**
 * The callback to execute after the request execution.
 * function (error: QueryError, resource: TResult, responseHeaders: any): Void {};
 */
typedef RequestCallback<TResult> = QueryError -> TResult -> Dynamic<String> -> Void;

/** Represents the error object returned from a failed query. */
typedef QueryError = {
    /** The response code corresponding to the error. */
    var code(default, never): Int;

    /** A String representing the error information. */
    var body(default, never): String;
}

/** The Sql query specification. */
typedef SqlQuerySpec = {
    /** The body of the query. */
    var query(default, default): String;

    /** The array of SqlParameters. */
    @:optional var parameters(default, default): Array<SqlParameter>;
}

/** The Sql query parameter. */
typedef SqlParameter = {
    /** The name of the parameter. */
    var name(default, default): String;

    /** The value of the parameter. */
    var value(default, default): Dynamic;//String;
}

/** Represents a QueryIterator Object, an implmenetation of feed or query response that enables traversal and iterating over the response in the Azure DocumentDB database service. */
extern class QueryIterator<TResultRow> {
    /**
     * Constructs a QueryIterator object
     * @param documentclient    - The documentclient object.
     * @param query             - A SQL query.
     * @param options           - Represents the feed options.
     * @param fetchFunctions    - A function to retrieve each page of data. An array of functions may be used to query more than one partition.
     * @param resourceLinkopt   - An optional parameter that represents the resourceLink (will be used in orderby/top/parallel query)
     */
    function new(documentclient: DocumentClient, query: Mixed2<String, SqlQuerySpec>, options: FeedOptions,
                fetchFunctions: ValueOrArray<RequestCallback<TResultRow>>, ?resourceLinkopt: String);

    /**
     * Retrieve the current element on the QueryIterator.
     * @param callback Function to execute for the current element.
     */
    function current(callback: RequestCallback<TResultRow>): Void;

    /**
     * Retrieve the next batch of the feed and pass them as an array to a function
     * @param callback Function execute on the feed response.
     */
    function executeNext(callback: RequestCallback<Array<TResultRow>>): Void;

    /**
     * Execute a provided function once per feed element.
     * @param callback Function to execute for each element. the function takes two parameters error, element. Note: the last element the callback
     *        will be called on will be undefined. If the callback explicitly returned false, the loop gets stopped.
     */
    function forEach(callback: RequestCallback<TResultRow>): Void;

    /**
     * Execute a provided function on the next element in the QueryIterator.
     * @param callback Function to execute for each element.
     */
    function nextItem(callback: RequestCallback<TResultRow>): Void;

    /**
     * Reset the QueryIterator to the beginning and clear all the resources inside it
     */
    function reset(): Void;

    /**
     * Retrieve all the elements of the feed and pass them as an array to a function
     * @param callback Function execute on the feed response.
     */
    function toArray(callback: RequestCallback<Array<TResultRow>>): Void;
}

/** Reprents an object with a unique identifier. */
typedef Resource = {
    /** The user-defined unique identifier for a document or other DocumentDB object (database, collection, procedure...) */
    var id(default, default): String;
}
/** Represents the common meta data for all DocumentDB objects. */
typedef RetrievedResource = {>Resource,
    /** This is a system generated property. The resource ID (_rid) is a system-generated identifier. */
    var _rid(default, never): String;
    /** This is a system generated property. It specifies the last updated timestamp of the resource. The value is a timestamp. */
    var _ts(default, never): Int;
    /** This is a system generated property. It is the unique addressable URI for the resource. */
    var _self(default, never): String;
    /** This is a system generated property that specifies the resource etag required for optimistic concurrency control. */
    var _etag(default, never): String;
}

typedef Database = {>Resource,
}
/** Represents the meta data for a database. */
typedef RetrievedDatabase = {>RetrievedResource, >Database,
    /** This is a system generated property that specifies the addressable path of the collections resource. */
    var _colls(default, never): String;
    /** This is a system generated property that specifies the addressable path of the users resource. */
    var _users(default, never): String;
}

/** Represents DocumentDB collection. */
typedef Collection = {>Resource,
    /** The indexing policy associated with the collection. */
    @:optional var indexingPolicy(default, default): IndexingPolicy;
    /** The default time to live in seconds for documents in a collection. */
    @:optional var defaultTtl(default, default): Int;
    /**
     * This is the partitioning configuration settings for collection.
     * If the x-ms-offer-throughput is over 10,000, then the collection must include a partitionKey definition.
     * If the x-ms-offer-throughput is equal to or under 10,000, then the collection must not include a partitionKey definition.
     */
    @:optional var partitionKey(default, default): CollectionPartitionKey;
}
/** Represents the meta data for a collection. */
typedef RetrievedCollection = {>RetrievedResource, >Collection,
    /** This is a system generated property that specifies the addressable path of the documents resource. */
    var _docs(default, never): String;
    /** This is a system generated property that specifies the addressable path of the stored procedures (sprocs) resource. */
    var _sprocs(default, never): String;
    /** This is a system generated property that specifies the addressable path of the triggers resource. */
    var _triggers(default, never): String;
    /** This is a system generated property that specifies the addressable path of the user-defined functions (udfs) resource. */
    var _udfs(default, never): String;
    /**
     * This is a system generated property that specifies the addressable path of the conflicts resource.
     * During an operation on a resource within a collection, if a conflict occurs, users can inspect the
     * conflicting resources by performing a GET on the conflicts URI path.
     */
    var _conflicts(default, never): String;
}
/**  The Indexing Policy represents the indexing policy configuration for a collection. */
typedef IndexingPolicy = {
    /** Specifies whether automatic indexing is enabled for a collection. */
    var automatic(default, default): Bool;
    /** The indexing mode (consistent or lazy) {@link IndexingMode}. */
    var indexingMode(default, default): IndexingMode;
    /** Represents the paths to be included for indexing. */
    var IncludedPaths(default, default): Array<IncludedPath>;
    /** Represents the paths to be excluded from indexing. */
    var ExcludedPaths(default, default): Array<ExcludedPath>;
}
typedef ExcludedPath ={
    var Path(default, default): String;
}
typedef IncludedPath = {
    /** Path to be indexed */
    var Path(default, default): String;
    var Indexes(default, default): Array<Index>;
}
/** Specifies the supported Index types. */
typedef Index = {
    var Kind(default, default): IndexKind;
    var DataType(default, default): String;
    var Precision(default, default): Int;
}
typedef CollectionPartitionKey = {
    /**
     * An array of paths using which data within the collection can be partitioned.
     * Paths must not contain a wildcard or a trailing slash. For example, the JSON property “AccountNumber” is specified as “/AccountNumber”.
     * The array must contain only a single value.
     */
    var paths(default, default): Array<String>;
    /** The algorithm used for partitioning. Only Hash is supported. */
    var kind(default, default): PartitionKind;
}
@:enum abstract IndexingMode(String) {
    var Consistent = "Consistent";
    var Lazy = "Lazy";
}
@:enum abstract IndexKind(String) {
    var Hash = "Hash";
    var Range = "Range";
    var Spatial = "Spatial";
}
@:enum abstract PartitionKind(String) {
    var Hash = "Hash";
}

/** Represents a custom document for storing in DocumentDB  */
typedef Document = {>Resource,
    /** The time to live in seconds of the document. */
    @:optional var ttl(default, default): Int;
    /** Custom properties */
    // [key: String]: any;
}
typedef RetrievedDocument = {>RetrievedResource, >Document,
    /** This is a system generated property that specifies the addressable path for the attachments resource. */
    var _attachments(default, never): String;
}

/** Represents a DocumentDB attachment */
typedef Attachment = {
    /** The MIME contentType of the attachment. */
    var contentType(default, default): String;
    /** Media link associated with the attachment content. */
    var media(default, default): String;
    /** Other properties */
    // [name: String]: any;
}
typedef RetrievedAttachment = {>RetrievedResource, >Attachment,
}

/** Represents a DocumentDB trigger. */
typedef Trigger = {
    /** The type of the trigger. Should be either 'pre' or 'post'. */
    var triggerType(default, default): TriggerType;
    /** The trigger operation. Should be one of 'all', 'create', 'update', 'delete', or 'replace'. */
    var triggerOperation(default, default): TriggerOperation;
    /** The user function. */
    var serverScript(default, default): Mixed2<Function, String>;
}
/** Represents the meta data for a trigger. */
typedef RetrievedTrigger = {>RetrievedResource, >Trigger,
}
@:enum abstract TriggerType(String) {
    var Pre = "Pre";
    var Post = "Post";
}
@:enum abstract TriggerOperation(String) {
    var All = "All";
    var Create = "Create";
    var Update = "Update";
    var Delete = "Delete";
    var Replace = "Replace";
}

/** Represents a DocumentDB stored procecedure. */
typedef StoredProcedure = {
    /** The user function. */
    var serverScript(default, default): Mixed2<Function, String>;
}
/** Represents the meta data for a stored procedure. */
typedef RetrievedStoredProcedure = {>RetrievedResource, >StoredProcedure,
}

/** Represents a DocumentDB user-defined function. */
typedef UserDefinedFunction = {
    /** Type of function */
    @:optional var userDefinedFunctionType(default, default): UserDefinedFunctionType;
    /** The user function. */
    var serverScript(default, default): Mixed2<Function, String>;
}
/** Represents the meta data for a user-defined function. */
typedef RetrievedUserDefinedFunction = {>RetrievedResource, >UserDefinedFunction,
}
@:enum abstract UserDefinedFunctionType(String) {
    var Javascript = "Javascript";
}

typedef Offer = {>Resource,
    var offerVersion(default, default): String;
    var content(default, default): OfferContent;
    var resource(default, default): String;
    var offerResourceId(default, default): String;
}
typedef RetrievedOffer = {>RetrievedResource, >Offer,
}
typedef OfferContent = {
    var offerThroughput(default, default): Int;
}

typedef User = {>Resource,
}
typedef RetrievedUser = {>RetrievedResource, >User,
    /** This is a system generated property denoting the addressable path of the feed of permissions resource. */
    var _permissions(default, never): String;
}

typedef Permission = {>Resource,
    /** The mode of the permission */
    var permissionMode(default, default): PermissionMode;
    /** The link of the resource that the permission will be applied to. */
    var resource(default, default): String;
}
typedef RetrievedPermission = {>RetrievedResource, >Permission,
    /** This is a system generated resource token for the particular resource and user. */
    var _token(default, never): String;
}
@:enum abstract PermissionMode(String) {
    var None = "None";
    var Read = "Read";
    var All = "All";
}

typedef DatabaseAccount = {
    var DatabasesLink(default, never): String;
    var MediaLink(default, never): String;
    var MaxMediaStorageUsageInMB(default, never): Int;
    var CurrentMediaStorageUsageInMB(default, never): Int;
    var ConsistencyPolicy(default, never): ConsistencyPolicy;
    var WritableLocations(default, never): Array<String>;
    var ReadableLocations(default, never): Array<String>;
}
typedef ConsistencyPolicy = {
    var defaultConsistencyLevel(default, default): ConsistencyLevel;
    var maxStalenessPrefix(default, default): Int;
    var maxStalenessIntervalInSeconds(default, default): Int;
}