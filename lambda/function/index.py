import json

def handler(event, context):
    """
    AWS Lambda handler function
    event: data passed to the function
    context: runtime information
    """
    
    # Get name from body if POST request
    name = "Cloud Engineer"
    
    if event.get('body'):
        try:
            body = json.loads(event['body'])
            name = body.get('name', 'Cloud Engineer')
        except:
            pass
    
    # Also check query string parameters
    if event.get('queryStringParameters'):
        name = event['queryStringParameters'].get('name', name)
    
    # Create response
    response = {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json'
        },
        'body': json.dumps({
            'message': f'Hello {name}! 🚀',
            'info': 'This is running on AWS Lambda!',
            'author': 'Victor - Cloud Engineer in training'
        })
    }
    
    return response
