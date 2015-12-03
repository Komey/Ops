from django.shortcuts import render
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
import os,json,time
# Create your views here.
def index(request):
    return render(request, 'dancer.html')
@csrf_exempt
def dancer(request):
    path = request.POST['path']
    dir = os.listdir(path)
    files = []
    for f in dir :
        file = {}
        file["name"] = f
        if(path.endswith("/") or len(path) == 1):
            file["time"] = time.ctime(os.stat(path+f).st_ctime)
        else:
            file["time"] = time.ctime(os.stat(path+'/'+f).st_ctime)
        files.append(file)
    print files
    return HttpResponse(json.dumps(files))