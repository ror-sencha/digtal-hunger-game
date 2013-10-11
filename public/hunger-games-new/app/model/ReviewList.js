Ext.define('HungerApp.model.ReviewList', {
    extend: 'Ext.data.Model',
    
    config: {
		identifier: 'uuid',
        fields: [
            {name: 'challenge_id', type: 'string'},
            {name: 'user_id', type: 'string'},
            {name: 'description', type: 'string'},
            {name: 'avatar_url', type: 'stirng'},
            {name: 'make_public', type: 'string'},
            {name: 'judge_can_view', type: 'string'},
            {name: 'date_submitted', type: 'string'}
        ],
    }
});
