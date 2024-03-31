<?php

use App\Models\User;
use App\Models\UvaTopic;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(User::class)->constrained()->onDelete('cascade')->comment('外鍵_使用者ID');
            $table->foreignIdFor(UvaTopic::class)->constrained()->onDelete('cascade')->comment('外鍵_題目ID');
            $table->text('video_url');
            $table->text('video_pic_url');
            $table->text('video_id');
            $table->text('content');
            $table->integer('likes')->default(0);
            $table->unsignedBigInteger('comments_count')->default(0);
            $table->text('code')->nullable();
            $table->text('code_editor_type')->nullable();
            $table->text('code_type')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('posts');
    }
};
